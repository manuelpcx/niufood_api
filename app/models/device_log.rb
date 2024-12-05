class DeviceLog < ApplicationRecord
  belongs_to :device

  validates :change, presence: true
end
