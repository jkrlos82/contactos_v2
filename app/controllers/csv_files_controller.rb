class CsvFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /csv_files
  # GET /csv_files.json
  def index
    @csv_files = current_user.csv_files.all.order('created_at DESC')
  end

  # GET /csv_files/1
  # GET /csv_files/1.json
  def show
  end

  # GET /csv_files/new
  def new
    @csv_file = current_user.csv_files.build
  end

  # GET /csv_files/1/edit
  def edit
  end

  # POST /csv_files
  # POST /csv_files.json
  def create
    #render plain: params[:no_model_fields]
    require 'csv'
    @data = params[:csv_file]
    headers = params[:no_model_fields].permit(params[:no_model_fields].keys).to_h
    headers = headers.sort_by{|k,v| v}
    headers = [headers[0][0], headers[1][0], headers[2][0], headers[3][0], headers[4][0], headers[5][0]]
    #render plain: headers
    rows = proccess_data @data
    #CSV.foreach(@data[:doc].path, headers: headers, col_sep: ';') do |row|
      #contact = current_user.contacts.new(row.to_hash)
      #contact.save
    #  rows << row.to_hash
    #end
    #render plain: rows[0]["name"]
    render plain: rows
    #@csv_file = current_user.csv_files.new(csv_file_params)
    count = 1
    @errors = []
    rows.each do |row|
      validate = RowsValidatorController.new(row)
      validate.validates 
      error = validate.errors 
      if !error.empty?
        @errors << error + " Linea " + count.to_s
      end
      count = count + 1
    end

    #render plain: @errors
    
    
    #proccess_data(@data)
    #if @csv_file.save
    #  redirect_to @csv_file, notice: 'Csv file was successfully created.' 
    #else
    #  render :new 
    #end
  end

  # PATCH/PUT /csv_files/1
  # PATCH/PUT /csv_files/1.json
  def update
    respond_to do |format|
      if @csv_file.update(csv_file_params)
        format.html { redirect_to @csv_file, notice: 'Csv file was successfully updated.' }
        format.json { render :show, status: :ok, location: @csv_file }
      else
        format.html { render :edit }
        format.json { render json: @csv_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csv_files/1
  # DELETE /csv_files/1.json
  def destroy
    @csv_file.destroy
    respond_to do |format|
      format.html { redirect_to csv_files_url, notice: 'Csv file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csv_file
      @csv_file = CsvFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def csv_file_params
      params.require(:csv_file).permit(:status, :errors, :doc)
    end

    def proccess_data(data)
      require 'csv'
      rows = []
      CSV.foreach(data[:doc].path, headers: true, col_sep: ';') do |row|
        #contact = current_user.contacts.new(row.to_hash)
        #contact.save
        rows << row.to_hash
      end
      return rows
    end
end
