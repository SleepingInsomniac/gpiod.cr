require "./line/settings"
require "./line/config"
require "./line/request"

module Gpiod
  class Line
    # Enums
    alias Value = LibGPIOD::LineValue
    alias Direction = LibGPIOD::LineDirection
    alias Edge = LibGPIOD::LineEdge
    alias Bias = LibGPIOD::LineBias
    alias Drive = LibGPIOD::LineDrive
    alias Clock = LibGPIOD::LineClock

    @line_info : LibGPIOD::LineInfo*

    def initialize(@line_info)
    end

    def initialize(chip : Chip, offset : UInt32)
      @line_info = LibGPIOD.chip_get_line_info(chip, offset)

      if @line_info.null?
        raise "Failed to get line info: #{chip.path}, #{offset}"
      end
    end

    def initialize(chip : Chip, name : String)
      initialize(chip, chip.line_offset(name))
    end

    def to_unsafe
      @line_info
    end

    def finalize
      LibGPIOD.line_info_free(self)
    end

    def offset
      LibGPIOD.line_info_get_offset(self)
    end

    def name
      ptr = LibGPIOD.line_info_get_name(self)
      ptr.null? ? nil : String.new(ptr)
    end

    def used?
      LibGPIOD.line_info_is_used(self)
    end

    def consumer
      ptr = LibGPIOD.line_info_get_consumer(self)
      ptr.null? ? nil : String.new(ptr)
    end

    def direction
      LibGPIOD.line_info_get_direction(self)
    end

    def edge_detection
      LibGPIOD.line_info_get_edge_detection(self)
    end

    def bias
      LibGPIOD.line_info_get_bias(self)
    end

    def drive
      LibGPIOD.line_info_get_drive(self)
    end

    def active_low?
      LibGPIOD.line_info_is_active_low(self)
    end

    def active_high?
      !active_low?
    end

    def debounced?
      LibGPIOD.line_info_is_debounced(self)
    end

    def debounce_period
      LibGPIOD.line_info_get_debounce_period_us(self)
    end

    def event_clock
      LibGPIOD.line_info_get_event_clock(self)
    end
  end
end
