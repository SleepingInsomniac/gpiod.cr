module Gpiod
  class Line
    class Request
      class Config
        @request_config : LibGPIOD::RequestConfig*

        def initialize(@request_config)
        end

        def initialize
          @request_config = LibGPIOD.request_config_new
        end

        def to_unsafe
          @request_config
        end

        def finalize
          LibGPIOD.request_config_free(self)
        end

        def consumer=(consumer)
          LibGPIOD.request_config_set_consumer(self, consumer)
        end

        def consumer
          String.new(LibGPIOD.request_config_get_consumer(self))
        end

        def event_buffer_size=(value)
          LibGPIOD.request_config_set_event_buffer_size(self, value)
        end

        def event_buffer_size
          LibGPIOD.request_config_get_event_buffer_size(self)
        end
      end
    end
  end
end
