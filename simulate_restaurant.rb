require 'net/http'
require 'json'

API_BASE_URL = 'http://localhost:3000/api/devices/change_status'
STATUS_OPTIONS = %w[operativo warning Problemas]

def fetch_first_restaurant
  uri = URI('http://localhost:3000/api/restaurants')
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    restaurants = JSON.parse(response.body)
    return restaurants.first['id'] if restaurants.any?

    puts "[#{Time.now}] No se encontraron restaurantes."
    nil
  else
    puts "[#{Time.now}] Error al obtener restaurantes: #{response.code} - #{response.body}"
    nil
  end
end

def fetch_devices(restaurant_id)
  uri = URI("http://localhost:3000/api/restaurants/#{restaurant_id}/devices")
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body).map { |device| device['id'] }
  else
    puts "[#{Time.now}] Error al obtener dispositivos: #{response.code} - #{response.body}"
    []
  end
end

def random_status(current_status)
  STATUS_OPTIONS.sample
end

def send_to_api(device_id, restaurant_id, new_status)
  uri = URI(API_BASE_URL)

  request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  request.body = {
    device: {
      id: device_id,
      restaurant_id: restaurant_id,
      status: new_status
    }
  }.to_json

  response = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end

  handle_response(response)
end

def handle_response(response)
  case response
  when Net::HTTPSuccess
    puts "[#{Time.now}] Éxito: #{response.body}"
  when Net::HTTPUnprocessableEntity
    puts "[#{Time.now}] Error de validación: #{response.body}"
  else
    puts "[#{Time.now}] Error inesperado: #{response.code} - #{response.body}"
  end
end

def simulate_devices
  restaurant_id = fetch_first_restaurant
  return unless restaurant_id

  loop do
    device_ids = fetch_devices(restaurant_id)
    if device_ids.empty?
      puts "[#{Time.now}] No se encontraron dispositivos para el restaurante #{restaurant_id}."
    else
      device_ids.each do |device_id|
        new_status = random_status('operativo')
        puts "[#{Time.now}] Enviando actualización: Dispositivo #{device_id}, Estado: #{new_status}"
        send_to_api(device_id, restaurant_id, new_status)
      end
    end
    sleep(rand(10..15))
  end
end

simulate_devices
