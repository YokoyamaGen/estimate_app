class CreateEstimates < ActiveRecord::Migration[7.2]
  def change
    create_table :estimates do |t|
      t.string :title
      t.string :client
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
