class PaymentType < ApplicationRecord
  has_many :orders, dependent: :nullify
  validates :name, presence: true
end
