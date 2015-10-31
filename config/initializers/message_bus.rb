MessageBus.redis_config = {url: "redis://127.0.0.1:6379"}
MessageBus.user_id_lookup do |env|
  env['rack.session']['user']
end