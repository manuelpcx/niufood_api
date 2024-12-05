class Device < ApplicationRecord
  belongs_to :restaurant
  has_many :device_logs, dependent: :destroy

  validates :name, :device_type, :status, presence: true
  validates :status, inclusion: { in: %w[operativo fallando mantenimiento] }
end
