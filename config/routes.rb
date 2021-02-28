Rails.application.routes.draw do
  root 'hello#say_hello'
  mount ActionCable.server, at: '/api/websocket'
end
