require "../src/gpiod"

def request_output_line(chip_path, offset, value, consumer)
  chip = Gpiod::Chip.new(chip_path)

  settings = Gpiod::Line::Settings.new
  settings.direction = Gpiod::Line::Direction::Output
  settings.output_value = Gpiod::Line::Value::Active

  line_config = Gpiod::Line::Config.new
  line_config.add_settings(offset, settings)

  request_config = Gpiod::Line::Request::Config.new
  request_config.consumer = "toggle-line-value"

  request = Gpiod::Line::Request.new(chip, request_config, line_config)
end

def toggle_line_value(value)
  value.active? ? Gpiod::Line::Value::Inactive : Gpiod::Line::Value::Active
end

chip_path = "/dev/gpiochip4"
line_offset = 17

request = request_output_line(chip_path, line_offset, Gpiod::Line::Value::Active, "toggle-line-value")
value = Gpiod::Line::Value::Active

10.times do
  value = toggle_line_value(value)
  sleep 0.5
  request.set_value(line_offset, value)
end

request.set_value(line_offset, Gpiod::Line::Value::Inactive)
