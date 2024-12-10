class DeviceUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "device_updates"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
