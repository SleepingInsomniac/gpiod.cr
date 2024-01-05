require "../src/gpiod"

chip = Gpiod::Chip.new("/dev/gpiochip4")
LINE = 17

settings = Gpiod::Line::Settings.new
settings.direction = Gpiod::Line::Direction::Input

line_config = Gpiod::Line::Config.new
line_config.add_settings(LINE, settings)

request_config = Gpiod::Line::Request::Config.new
request_config.consumer = "get-line-value"

request = Gpiod::Line::Request.new(chip, request_config, line_config)

value = request.value(LINE)

puts "Line #{LINE}: #{value}"
