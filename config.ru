require './app'

# Experimental StatsD Emitter for ActiveRecord
# require 'napa/active_record_extensions/stats.rb'

# use Rack::Cors do
#   allow do
#     origins '*'
#     resource '*', headers: :any, methods: :any
#   end
# end
#
# use Honeybadger::Rack
# use Napa::Middleware::Logger

use Napa::Middleware::AppMonitor
run ApplicationApi

use Rack::Static, root: "public", index: 'index.html'
