require "./lib_gpiod"

module Gpiod
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  def self.api_version
    String.new(LibGPIOD.api_version)
  end

  def self.device_paths
    Dir.glob("/dev/*").select { |path| LibGPIOD.is_gpiochip_device(path) }
  end
end

require "./gpiod/chip"
require "./gpiod/line"
require "./gpiod/info_event"
