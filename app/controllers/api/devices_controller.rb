class Api::DevicesController < ApplicationController
  before_action :set_device, only: [:update]

  def create
    device = Device.new(device_params)

    if device.save
      log_change(device, "Device created")
      render json: { message: "Device created successfully", device: device }, status: :created
    else
      render json: { errors: device.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @device.update(device_params)
      log_change(@device, "Device updated")
      render json: { message: "Device updated successfully", device: @device }, status: :ok
    else
      render json: { errors: @device.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_device
    @device = Device.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Device not found" }, status: :not_found
  end

  def device_params
    params.require(:device).permit(:restaurant_id, :name, :device_type, :status, :last_maintenance_at)
  end

  def log_change(device, change)
    DeviceLog.create!(device: device, change: change)
  end
end
