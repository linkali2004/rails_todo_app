class ResponseChannel < ApplicationCable::Channel
  def subscribed
    stream_from "resp"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
