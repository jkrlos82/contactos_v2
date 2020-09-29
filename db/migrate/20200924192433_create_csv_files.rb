class CreateCsvFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :csv_files do |t|
      t.text :status
      t.text :file_errors 
      t.integer :user_id
      
      t.timestamps
    end
  end
end
