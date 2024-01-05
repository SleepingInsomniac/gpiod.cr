module Gpiod
  class Chip
    class Info
      @info : LibGPIOD::ChipInfo*

      def initialize(chip : Chip)
        @info = LibGPIOD.chip_get_info(chip)

        if @info.null?
          raise "Failed to read info: #{chip.path}"
        end
      end

      def to_unsafe
        @info
      end

      def finalize
        LibGPIOD.chip_info_free(self)
      end

      getter name do
        String.new(LibGPIOD.chip_info_get_name(self))
      end

      getter label do
        String.new(LibGPIOD.chip_info_get_label(self))
      end

      def num_lines
        LibGPIOD.chip_info_get_num_lines(self)
      end
    end
  end
end
