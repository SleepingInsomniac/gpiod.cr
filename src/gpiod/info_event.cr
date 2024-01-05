module Gpiod
  class InfoEvent
    alias EventType = LibGPIOD::InfoEventType

    @info_event : LibGPIOD::InfoEvent*

    def initialize(@info_event)
    end

    def to_unsafe
      @info_event
    end

    def finalize
      LibGPIOD.info_event_free(self)
    end

    def event_type
      LibGPIOD.info_event_get_event_type(self)
    end

    def timestamp
      LibGPIOD.info_event_get_timestamp_ns(self)
    end

    def line
      LibGPIOD.info_event_get_line_info(self)
    end
  end
end
