class Restaurant < ApplicationRecord
  has_many :devices, dependent: :destroy

  validates :name, :city, :status, presence: true
  calidates :status, inclusion: { in: %w[operativo warning problemas] }
end
