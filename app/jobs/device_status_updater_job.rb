class DeviceStatusUpdaterJob < ApplicationJob
  queue_as :default

  def perform(device_id, new_status)
    device = Device.find(device_id)
    device.update!(status: new_status)
    DeviceLog.create!(device: device, change: "Status updated to #{new_status}")
  end
end
