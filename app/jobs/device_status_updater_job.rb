class DeviceStatusUpdaterJob < ApplicationJob
  queue_as :default

  def perform(device_id, new_status)
    device = Device.find(device_id)
    device.update!(status: new_status, last_maintenance_at: DateTime.current)
    DeviceLog.create!(device: device, change: "Status updated to #{new_status}")
    restaurant = device.restaurant
    update_status_restaurant(restaurant)
    ActionCable.server.broadcast("device_updates", device.as_json)
  end

  private

  def update_status_restaurant restaurant
    devices_status = restaurant.devices.pluck(:status)

    new_status = if devices_status.include?("warning")
                  'warning'
                 elsif devices_status.include?('Problemas')
                  'Problemas'
                 else
                  'operativo'
                 end

    restaurant.update!(status: new_status) if restaurant.status != new_status
  end
end
