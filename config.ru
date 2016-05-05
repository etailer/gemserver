#\ -s puma

require 'rubygems'
require 'geminabox'

Geminabox.data = ENV.fetch 'MOUNT_POINT'

use Rack::Auth::Basic do |_, token|
  token == ENV.fetch('TOKEN', '')
end

run Geminabox::Server
