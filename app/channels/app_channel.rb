class AppChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "subscribed params: #{params}"
    current_visitor.update(online: true)
    stream_from "app_stream_#{params[:visitor_id]}"
    stream_from "global_stream"
    say_visitors_count
    say_internal_id
  end

  def received
    Rails.logger.info "received: #{data}"
  end

  def send_message(data)
    Rails.logger.info "received CMD send_message: #{data}"
  end

  def unsubscribed
    Rails.logger.info "unsubscribed params: #{params}"
    current_visitor.update(online: false)
    say_visitors_count
  end

  private

  def current_visitor
    Visitor.where(visitor_id: params[:visitor_id]).first_or_create
  end

  def say_visitors_count
    visitors_count = Visitor.where(online: true).size
    ActionCable.server.broadcast "global_stream", { method: :update_visitors_count, content: visitors_count }
  end

  def say_internal_id
    ActionCable.server.broadcast "app_stream_#{params[:visitor_id]}", method: :update_message,
                                                                      content: "Hello, your id is #{current_visitor.id}" 
  end
end
