# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

restaurant = Restaurant.create(name: "niu sushi", city: "santiago", status: "operativo")
device1 = Device.create(name: "POS de venta", device_type: "POS", last_maintenance_at: DateTime.current, status: "operativo", restaurant_id: restaurant.id)
DeviceLog.create(device: device1, change: "Device created")
device2 = Device.create(name: "Impresora de cocina", device_type: "Impresora", last_maintenance_at: DateTime.current, status: "operativo", restaurant_id: restaurant.id)
DeviceLog.create(device: device2, change: "Device created")
device3 = Device.create(name: "Servidor de red", device_type: "Red", last_maintenance_at: DateTime.current, status: "operativo", restaurant_id: restaurant.id)
DeviceLog.create(device: device3, change: "Device created")

3.times do |i|
    restaurant = Restaurant.create(name: "niu sushi #{i}", city: "santiago", status: "operativo")
    device1 = Device.create(name: "POS de venta #{i}", device_type: "POS", last_maintenance_at: DateTime.current, status: "operativo", restaurant_id: restaurant.id)
    DeviceLog.create(device: device1, change: "Device created")
    device2 = Device.create(name: "Impresora de cocina #{i}", device_type: "Impresora", last_maintenance_at: DateTime.current, status: "operativo", restaurant_id: restaurant.id)
    DeviceLog.create(device: device2, change: "Device created")
    device3 = Device.create(name: "Servidor de red #{i}", device_type: "Red", last_maintenance_at: DateTime.current, status: "operativo", restaurant_id: restaurant.id)
    DeviceLog.create(device: device3, change: "Device created")
end
