class Api::RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.includes(:devices)
    render json: @restaurants.map { |restaurant|
      {
        id: restaurant.id,
        name: restaurant.name,
        status: restaurant.status,
        devices: restaurant.devices.map { |device|
          {
            id: device.id,
            name: device.name,
            status: device.status
          }
        }
      }
    }
  end

  def show
    render json: @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      render json: @restaurant, status: :created
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Restaurante no encontrado" }, status: :not_found
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :city, :status)
  end
end
