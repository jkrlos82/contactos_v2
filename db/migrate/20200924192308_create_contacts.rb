class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.text :name
      t.date :dob
      t.text :telephone
      t.text :address
      t.integer :credit_card
      t.integer :last_four
      t.text :franchise
      t.text :email
      t.integer :user_id

      t.timestamps
    end
  end
end
