class CreateDocuments < ActiveRecord::Migration[7.2]
  def change
    create_table :documents do |t|
      t.string :name
      t.decimal :amount
      t.string :client
      t.string :project
      t.date :transaction_date
      t.string :file_path

      t.timestamps
    end
  end
end
