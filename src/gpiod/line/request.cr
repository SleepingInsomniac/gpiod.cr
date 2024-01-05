require "./request/config"

module Gpiod
  class Line
    class Request
      @request : LibGPIOD::LineRequest*

      def initialize(@request)
      end

      def initialize(chip : Chip, request_config : Config, line_config : Line::Config)
        @request = LibGPIOD.chip_request_lines(chip, request_config, line_config)
      end

      def to_unsafe
        @request
      end

      def finalize
        LibGPIOD.line_request_release(self)
      end

      getter chip_name do
        String.new(LibGPIOD.line_request_get_chip_name(self))
      end

      def num_requested_lines
        LibGPIOD.line_request_get_num_requested_lines(self)
      end

      def requested_offsets
        size = LibGPIOD.line_request_get_requested_offsets(self, out offsets, num_requested_lines)
        Slice.new(offsets, size)
      end

      def value(offset)
        LibGPIOD.line_request_get_value(self, offset)
      end

      # def values_subset
      #   LibGPIOD.line_request_get_values_subset(self)
      # end

      def values
        ret = LibGPIOD.line_request_get_values(self, out line_values)
        raise "Unable to get line values" if ret == -1
        Slice.new(line_values, num_requested_lines)
      end

      def set_value(offset, value)
        LibGPIOD.line_request_set_value(self, offset, value)
      end

      # def values_subset=(values)
      #   LibGPIOD.line_request_set_values_subset(self, values)
      # end

      # def values=(values)
      #   LibGPIOD.line_request_set_values(self, values)
      # end

      def reconfigure_lines(config : Config | LibGPIOD::RequestConfig)
        ret = LibGPIOD.line_request_reconfigure_lines(self, config)
        raise "Unable to reconfigure lines" if ret == -1
      end

      def fd
        LibGPIOD.line_request_get_fd(self)
      end

      def wait_edge_events(timeout)
        case LibGPIOD.line_request_wait_edge_events(self, timeout)
        when 0 then false
        when 1 then true
        else        raise "Error waiting for edge events"
        end
      end

      # def read_edge_events
      #   LibGPIOD.line_request_read_edge_events(self)
      # end
    end
  end
end
