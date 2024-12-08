class DeviceStatusUpdaterJob < ApplicationJob
  queue_as :default

  def perform(device_id, new_status)
    device = Device.find(device_id)
    device.update!(status: new_status)
    DeviceLog.create!(device: device, change: "Status updated to #{new_status}")

    restaurant = device.restaurant
    update_status_restaurant(restaurant)
  end

  private

  def update_status_restaurant restaurant
    devices_status = restaurant.devices.pluck(:status)

    new_status = if devices_status.include?("fallando")
                  'fallando'
                 elsif devices_status.include?('mantenimiento')
                  'mantenimiento'
                 else
                  'operativo'
                 end

    restaurant.update!(status: new_status) if restaurant.status != new_status
  end
end
