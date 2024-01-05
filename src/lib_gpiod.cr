@[Link(ldflags: "`pkg-config --libs libgpiod`")]
lib LibGPIOD
  struct Chip
    pointer : Void*
  end

  struct ChipInfo
    pointer : Void*
  end

  struct LineInfo
    pointer : Void*
  end

  struct LineSettings
    pointer : Void*
  end

  struct LineConfig
    pointer : Void*
  end

  struct RequestConfig
    pointer : Void*
  end

  struct LineRequest
    pointer : Void*
  end

  struct InfoEvent
    pointer : Void*
  end

  struct EdgeEvent
    pointer : Void*
  end

  struct EdgeEventBuffer
    pointer : Void*
  end

  fun chip_open = gpiod_chip_open(path : LibC::Char*) : Chip*
  fun chip_close = gpiod_chip_close(chip : Chip*)
  fun chip_get_info = gpiod_chip_get_info(chip : Chip*) : ChipInfo*
  fun chip_get_path = gpiod_chip_get_path(chip : Chip*) : LibC::Char*
  fun chip_get_line_info = gpiod_chip_get_line_info(chip : Chip*, offset : LibC::UInt) : LineInfo*
  fun chip_watch_line_info = gpiod_chip_watch_line_info(chip : Chip*, offset : LibC::UInt) : LineInfo*
  fun chip_unwatch_line_info = gpiod_chip_unwatch_line_info(chip : Chip*, offset : LibC::UInt) : LibC::Int
  fun chip_get_fd = gpiod_chip_get_fd(chip : Chip*) : LibC::Int
  fun chip_wait_info_event = gpiod_chip_wait_info_event(chip : Chip*, timeout_ns : LibC::Int64T) : LibC::Int
  fun chip_read_info_event = gpiod_chip_read_info_event(chip : Chip*) : InfoEvent*
  fun chip_get_line_offset_from_name = gpiod_chip_get_line_offset_from_name(chip : Chip*, name : LibC::Char*) : LibC::Int
  fun chip_request_lines = gpiod_chip_request_lines(chip : Chip*, req_cfg : RequestConfig*, line_cfg : LineConfig*) : LineRequest*
  fun chip_info_free = gpiod_chip_info_free(info : ChipInfo*)
  fun chip_info_get_name = gpiod_chip_info_get_name(info : ChipInfo*) : LibC::Char*
  fun chip_info_get_label = gpiod_chip_info_get_label(info : ChipInfo*) : LibC::Char*
  fun chip_info_get_num_lines = gpiod_chip_info_get_num_lines(info : ChipInfo*) : LibC::SizeT

  enum LineValue
    Error    = -1
    Inactive =  0
    Active   =  1
  end

  enum LineDirection
    AsIs   = 1
    Input
    Output
  end

  enum LineEdge
    None    = 1
    Rising
    Falling
    Both
  end

  enum LineBias
    AsIs      = 1
    Unknown
    Disabled
    Pull_UP
    Pull_DOWN
  end

  enum LineDrive
    PushPull   = 1
    OpenDrain
    OpenSource
  end

  enum LineClock
    Monotonic = 1
    Realtime
    Hte
  end

  fun line_info_free = gpiod_line_info_free(info : LineInfo*)
  fun line_info_copy = gpiod_line_info_copy(info : LineInfo*) : LineInfo*
  fun line_info_get_offset = gpiod_line_info_get_offset(info : LineInfo*) : LibC::UInt
  fun line_info_get_name = gpiod_line_info_get_name(info : LineInfo*) : LibC::Char*
  fun line_info_is_used = gpiod_line_info_is_used(info : LineInfo*) : Bool
  fun line_info_get_consumer = gpiod_line_info_get_consumer(info : LineInfo*) : LibC::Char*
  fun line_info_get_direction = gpiod_line_info_get_direction(info : LineInfo*) : LineDirection
  fun line_info_get_edge_detection = gpiod_line_info_get_edge_detection(info : LineInfo*) : LineEdge
  fun line_info_get_bias = gpiod_line_info_get_bias(info : LineInfo*) : LineBias
  fun line_info_get_drive = gpiod_line_info_get_drive(info : LineInfo*) : LineDrive
  fun line_info_is_active_low = gpiod_line_info_is_active_low(info : LineInfo*) : Bool
  fun line_info_is_debounced = gpiod_line_info_is_debounced(info : LineInfo*) : Bool
  fun line_info_get_debounce_period_us = gpiod_line_info_get_debounce_period_us(info : LineInfo*) : LibC::ULong
  fun line_info_get_event_clock = gpiod_line_info_get_event_clock(info : LineInfo*) : LineClock

  enum InfoEventType
    LineRequested     = 1
    LineReleased
    LineConfigChanged
  end

  fun info_event_free = gpiod_info_event_free(event : InfoEvent*)
  fun info_event_get_event_type = gpiod_info_event_get_event_type(event : InfoEvent*) : InfoEventType
  fun info_event_get_timestamp_ns = gpiod_info_event_get_timestamp_ns(event : InfoEvent*) : LibC::UInt64T
  fun info_event_get_line_info = gpiod_info_event_get_line_info(event : InfoEvent*) : LineInfo*
  fun line_settings_new = gpiod_line_settings_new : LineSettings*
  fun line_settings_free = gpiod_line_settings_free(settings : LineSettings*)
  fun line_settings_reset = gpiod_line_settings_reset(settings : LineSettings*)
  fun line_settings_copy = gpiod_line_settings_copy(settings : LineSettings*) : LineSettings*
  fun line_settings_set_direction = gpiod_line_settings_set_direction(settings : LineSettings*, direction : LineDirection) : LibC::Int
  fun line_settings_get_direction = gpiod_line_settings_get_direction(settings : LineSettings*) : LineDirection
  fun line_settings_set_edge_detection = gpiod_line_settings_set_edge_detection(settings : LineSettings*, edge : LineEdge) : LibC::Int
  fun line_settings_get_edge_detection = gpiod_line_settings_get_edge_detection(settings : LineSettings*) : LineEdge
  fun line_settings_set_bias = gpiod_line_settings_set_bias(settings : LineSettings*, bias : LineBias) : LibC::Int
  fun line_settings_get_bias = gpiod_line_settings_get_bias(settings : LineSettings*) : LineBias
  fun line_settings_set_drive = gpiod_line_settings_set_drive(settings : LineSettings*, drive : LineDrive) : LibC::Int
  fun line_settings_get_drive = gpiod_line_settings_get_drive(settings : LineSettings*) : LineDrive
  fun line_settings_set_active_low = gpiod_line_settings_set_active_low(settings : LineSettings*, active_low : Bool)
  fun line_settings_get_active_low = gpiod_line_settings_get_active_low(settings : LineSettings*) : Bool
  fun line_settings_set_debounce_period_us = gpiod_line_settings_set_debounce_period_us(settings : LineSettings*, period : LibC::ULong)
  fun line_settings_get_debounce_period_us = gpiod_line_settings_get_debounce_period_us(settings : LineSettings*) : LibC::ULong
  fun line_settings_set_event_clock = gpiod_line_settings_set_event_clock(settings : LineSettings*, event_clock : LineClock) : LibC::Int
  fun line_settings_get_event_clock = gpiod_line_settings_get_event_clock(settings : LineSettings*) : LineClock
  fun line_settings_set_output_value = gpiod_line_settings_set_output_value(settings : LineSettings*, value : LineValue) : LibC::Int
  fun line_settings_get_output_value = gpiod_line_settings_get_output_value(settings : LineSettings*) : LineValue
  fun line_config_new = gpiod_line_config_new : LineConfig*
  fun line_config_free = gpiod_line_config_free(config : LineConfig*)
  fun line_config_reset = gpiod_line_config_reset(config : LineConfig*)
  fun line_config_add_line_settings = gpiod_line_config_add_line_settings(config : LineConfig*, offsets : LibC::UInt*, num_offsets : LibC::SizeT, settings : LineSettings*) : LibC::Int
  fun line_config_get_line_settings = gpiod_line_config_get_line_settings(config : LineConfig*, offset : LibC::UInt) : LineSettings*
  fun line_config_set_output_values = gpiod_line_config_set_output_values(config : LineConfig*, values : LineValue*, num_values : LibC::SizeT) : LibC::Int
  fun line_config_get_num_configured_offsets = gpiod_line_config_get_num_configured_offsets(config : LineConfig*) : LibC::SizeT
  fun line_config_get_configured_offsets = gpiod_line_config_get_configured_offsets(config : LineConfig*, offsets : LibC::UInt*, max_offsets : LibC::SizeT) : LibC::SizeT
  fun request_config_new = gpiod_request_config_new : RequestConfig*
  fun request_config_free = gpiod_request_config_free(config : RequestConfig*)
  fun request_config_set_consumer = gpiod_request_config_set_consumer(config : RequestConfig*, consumer : LibC::Char*)
  fun request_config_get_consumer = gpiod_request_config_get_consumer(config : RequestConfig*) : LibC::Char*
  fun request_config_set_event_buffer_size = gpiod_request_config_set_event_buffer_size(config : RequestConfig*, event_buffer_size : LibC::SizeT)
  fun request_config_get_event_buffer_size = gpiod_request_config_get_event_buffer_size(config : RequestConfig*) : LibC::SizeT
  fun line_request_release = gpiod_line_request_release(request : LineRequest*)
  fun line_request_get_chip_name = gpiod_line_request_get_chip_name(request : LineRequest*) : LibC::Char*
  fun line_request_get_num_requested_lines = gpiod_line_request_get_num_requested_lines(request : LineRequest*) : LibC::SizeT
  fun line_request_get_requested_offsets = gpiod_line_request_get_requested_offsets(request : LineRequest*, offsets : LibC::UInt*, max_offsets : LibC::SizeT) : LibC::SizeT
  fun line_request_get_value = gpiod_line_request_get_value(request : LineRequest*, offset : LibC::UInt) : LineValue
  fun line_request_get_values_subset = gpiod_line_request_get_values_subset(request : LineRequest*, num_values : LibC::SizeT, offsets : LibC::UInt*, values : LineValue*) : LibC::Int
  fun line_request_get_values = gpiod_line_request_get_values(request : LineRequest*, values : LineValue*) : LibC::Int
  fun line_request_set_value = gpiod_line_request_set_value(request : LineRequest*, offset : LibC::UInt, value : LineValue) : LibC::Int
  fun line_request_set_values_subset = gpiod_line_request_set_values_subset(request : LineRequest*, num_values : LibC::SizeT, offsets : LibC::UInt*, values : LineValue*) : LibC::Int
  fun line_request_set_values = gpiod_line_request_set_values(request : LineRequest*, values : LineValue*) : LibC::Int
  fun line_request_reconfigure_lines = gpiod_line_request_reconfigure_lines(request : LineRequest*, config : LineConfig*) : LibC::Int
  fun line_request_get_fd = gpiod_line_request_get_fd(request : LineRequest*) : LibC::Int
  fun line_request_wait_edge_events = gpiod_line_request_wait_edge_events(request : LineRequest*, timeout_ns : LibC::Int64T) : LibC::Int
  fun line_request_read_edge_events = gpiod_line_request_read_edge_events(request : LineRequest*, buffer : EdgeEventBuffer*, max_events : LibC::SizeT) : LibC::Int

  enum EdgeEventType
    RisingEdge  = 1
    FallingEdge
  end

  fun edge_event_free = gpiod_edge_event_free(event : EdgeEvent*)
  fun edge_event_copy = gpiod_edge_event_copy(event : EdgeEvent*) : EdgeEvent*
  fun edge_event_get_event_type = gpiod_edge_event_get_event_type(event : EdgeEvent*) : EdgeEventType
  fun edge_event_get_timestamp_ns = gpiod_edge_event_get_timestamp_ns(event : EdgeEvent*) : LibC::UInt64T
  fun edge_event_get_line_offset = gpiod_edge_event_get_line_offset(event : EdgeEvent*) : LibC::UInt
  fun edge_event_get_global_seqno = gpiod_edge_event_get_global_seqno(event : EdgeEvent*) : LibC::ULong
  fun edge_event_get_line_seqno = gpiod_edge_event_get_line_seqno(event : EdgeEvent*) : LibC::ULong
  fun edge_event_buffer_new = gpiod_edge_event_buffer_new(capacity : LibC::SizeT) : EdgeEventBuffer*
  fun edge_event_buffer_get_capacity = gpiod_edge_event_buffer_get_capacity(buffer : EdgeEventBuffer*) : LibC::SizeT
  fun edge_event_buffer_free = gpiod_edge_event_buffer_free(buffer : EdgeEventBuffer*)
  fun edge_event_buffer_get_event = gpiod_edge_event_buffer_get_event(buffer : EdgeEventBuffer*, index : LibC::ULong) : EdgeEvent*
  fun edge_event_buffer_get_num_events = gpiod_edge_event_buffer_get_num_events(buffer : EdgeEventBuffer*) : LibC::SizeT
  fun is_gpiochip_device = gpiod_is_gpiochip_device(path : LibC::Char*) : Bool
  fun api_version = gpiod_api_version : LibC::Char*
end
