class Document < ApplicationRecord
  has_one_attached :pdf_file
  
  validates :name, presence: true
  validates :client, presence: true
  validates :project, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_date, presence: true
end
