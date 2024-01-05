require "../src/gpiod"

line_name = "PIN11"

chip : Gpiod::Chip? = nil

Gpiod.device_paths.each do |path|
  c = Gpiod::Chip.new(path)

  if c.line_offset?(line_name)
    chip = c
    break
  end
end

if c = chip
  puts "#{line_name} is on #{c.info.name} [#{c.info.label}] (#{c.info.num_lines})"
else
  puts "Couldn't find chip with line #{line_name}"
end
