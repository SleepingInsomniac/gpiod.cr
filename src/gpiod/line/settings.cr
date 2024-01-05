module Gpiod
  class Line
    class Settings
      @line_settings : LibGPIOD::LineSettings*

      def initialize(@line_settings)
      end

      def initialize
        @line_settings = LibGPIOD.line_settings_new
      end

      def to_unsafe
        @line_settings
      end

      def finalize
        LibGPIOD.line_settings_free(@line_settings)
      end

      def reset
        LibGPIOD.line_settings_reset(@line_settings)
      end

      def copy
        LibGPIOD.line_settings_copy(@line_settings)
      end

      def direction=(direction : Direction)
        LibGPIOD.line_settings_set_direction(@line_settings, direction)
      end

      def direction
        LibGPIOD.line_settings_get_direction(@line_settings)
      end

      def edge_detection=(edge : Edge)
        LibGPIOD.line_settings_set_edge_detection(@line_settings, edge)
      end

      def edge_detection
        LibGPIOD.line_settings_get_edge_detection(@line_settings)
      end

      def bias=(bias : Bias)
        LibGPIOD.line_settings_set_bias(@line_settings, bias)
      end

      def bias
        LibGPIOD.line_settings_get_bias(@line_settings)
      end

      def drive=(drive : Drive)
        LibGPIOD.line_settings_set_drive(@line_settings, drive)
      end

      def drive
        LibGPIOD.line_settings_get_drive(@line_settings)
      end

      def active_low=(low : Bool)
        LibGPIOD.line_settings_set_active_low(@line_settings, low)
      end

      def active_low?
        LibGPIOD.line_settings_get_active_low(@line_settings)
      end

      def debounce_period(us : LibC::ULong)
        LibGPIOD.line_settings_set_debounce_period_us(@line_settings, us)
      end

      def debounce_period
        LibGPIOD.line_settings_get_debounce_period_us(@line_settings)
      end

      def event_clock=(event_clock : Clock)
        LibGPIOD.line_settings_set_event_clock(@line_settings, event_clock)
      end

      def event_clock
        LibGPIOD.line_settings_get_event_clock(@line_settings)
      end

      def output_value=(line_value : Value)
        LibGPIOD.line_settings_set_output_value(@line_settings, line_value)
      end

      def output_value
        LibGPIOD.line_settings_get_output_value(@line_settings)
      end
    end
  end
end
