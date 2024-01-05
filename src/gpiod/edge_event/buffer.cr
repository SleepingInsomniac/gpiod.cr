module Gpiod
  class EdgeEvent
    class Buffer
      include Enumerable(EdgeEvent)

      @buffer : LibGPIOD::EdgeEventBuffer*

      def initialize(@buffer)
      end

      # size of 0 defaults to 64, min = 1, max = 1024
      def initialize(size = 0)
        @buffer = LibGPIOD.edge_event_buffer_new(self, size)
      end

      def to_unsafe
        @buffer
      end

      def finalize
        LibGPIOD.edge_event_buffer_free(self)
      end

      def capacity
        LibGPIOD.edge_event_buffer_get_capacity(self)
      end

      def [](index)
        tmp_ptr = LibGPIOD.edge_event_buffer_get_event(self, index)
        raise "Null edge event at index #{index}" if tmp_ptr.null?
        ptr = LibGPIOD.edge_event_copy(tmp_ptr)
        raise "Unable to copy edge event" if ptr.null?
        EdgeEvent.new(ptr)
      end

      def size
        LibGPIOD.edge_event_buffer_get_num_events(self)
      end

      def each(&)
        0.upto(size) do |i|
          yield self[i]
        end
      end
    end
  end
end
