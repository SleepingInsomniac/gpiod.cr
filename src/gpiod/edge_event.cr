module Gpiod
  class EdgeEvent
    @edge_event : LibGPIOD::EdgeEvent*

    def initialize(@edge_event)
    end

    def to_unsafe
      @edge_event
    end

    def finalize
      LibGPIOD.edge_event_free(self)
    end

    def copy
      ptr = LibGPIOD.edge_event_copy(self)
      raise "Unable to copy edge event" if ptr.null?
      new(ptr)
    end

    def event_type
      LibGPIOD.edge_event_get_event_type(self)
    end

    def timestamp
      LibGPIOD.edge_event_get_timestamp_ns(self)
    end

    def line_offset
      LibGPIOD.edge_event_get_line_offset(self)
    end

    def global_seqno
      LibGPIOD.edge_event_get_global_seqno(self)
    end

    def line_seqno
      LibGPIOD.edge_event_get_line_seqno(self)
    end
  end
end
