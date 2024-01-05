require "../src/gpiod"

chip = Gpiod::Chip.new("/dev/gpiochip4")
puts "#{chip.info.name} [#{chip.info.label}] (#{chip.info.num_lines})"
