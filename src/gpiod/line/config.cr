module Gpiod
  class Line
    class Config
      @config : LibGPIOD::LineConfig*

      def initialize(@config)
      end

      def initialize
        @config = LibGPIOD.line_config_new
      end

      def to_unsafe
        @config
      end

      def finalize
        LibGPIOD.line_config_free(self)
      end

      def reset
        LibGPIOD.line_config_reset(self)
      end

      def add_settings(offset : Int, settings : Settings)
        ptr = StaticArray[offset.to_u32].to_unsafe
        LibGPIOD.line_config_add_line_settings(self, ptr, 1, settings)
      end

      def add_settings(offsets : Slice(UInt32), settings : Settings)
        LibGPIOD.line_config_add_line_settings(self, offsets, offsets.size, settings)
      end

      def line_settings(offset)
        Settings.new(LibGPIOD.line_config_get_line_settings(self, offset))
      end

      def output_values=(values : Slice(Value))
        LibGPIOD.line_config_set_output_values(self, values, values.size)
      end

      def num_configured_offsets
        LibGPIOD.line_config_get_num_configured_offsets(self)
      end

      def configured_offsets
        size = LibGPIOD.line_config_get_configured_offsets(self, out offsets, 54)
        Slice.new(offsets, size)
      end
    end
  end
end
