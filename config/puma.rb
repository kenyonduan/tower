environment 'production'
bind 'tcp://0.0.0.0:8992'
pidfile './tmp/pids/puma.pid'
threads 3, 12
daemonize true

# message_bus
on_worker_boot do
  MessageBus.after_fork
end