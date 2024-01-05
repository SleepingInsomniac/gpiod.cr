require "../src/gpiod"

chip = Gpiod::Chip.new("/dev/gpiochip4")
line = chip[17]

puts "line #{line.offset}: #{line.name} #{line.consumer || "unused"} #{line.direction} #{line.active_low? ? "active-low" : "active-high"}"
