worker_processes Integer(ENV['UNICORN_WORKERS'] || 2)
timeout Integer(ENV['UNICORN_TIMEOUT'] || 35)
working_directory "/app"
preload_app true

listen "/tmp/web_server.sock", :backlog => Integer(ENV['UNICORN_BACKLOG'] || 64)
pid '/tmp/web_server.pid'
stderr_path "/app/log/unicorn.stderr.log"
stdout_path "/app/log/unicorn.stdout.log"

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
