class Restaurant < ApplicationRecord
  has_many :devices, dependent: :destroy

  validates :name, :city, :status, presence: true
  validates :status, inclusion: { in: %w[operativo warning problemas] }
end
