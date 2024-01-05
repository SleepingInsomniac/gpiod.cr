require "./chip/info"

module Gpiod
  class Chip
    @chip : LibGPIOD::Chip*

    def initialize(@chip)
    end

    def initialize(path)
      @chip = LibGPIOD.chip_open(path)

      if @chip.null?
        raise "Failed to open chip: #{path}"
      end
    end

    def to_unsafe
      @chip
    end

    def finalize
      LibGPIOD.chip_close(self)
    end

    getter info : Info do
      Info.new(self)
    end

    getter path do
      String.new(LibGPIOD.chip_get_path(self))
    end

    def line_offset?(name : String)
      offset = LibGPIOD.chip_get_line_offset_from_name(self, name)
      offset == -1 ? nil : offset.to_u32
    end

    def line_offset(name : String) : UInt32
      if offset = line_offset?(name)
        offset
      else
        raise "Chip '#{path}' does not have line named '#{name}'"
      end
    end

    def [](offset_or_name : UInt32 | String)
      Line.new(self, offset_or_name)
    end

    def watch(offset)
      Line.new(LibGPIOD.chip_watch_line_info(self, offset))
    end
  end
end
