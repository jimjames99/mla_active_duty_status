module MlaActiveDutyStatus

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  # For tests.
  def self.reset
    @configuration = Configuration.new
  end

  class Configuration
    attr_accessor :mla_host, :mla_path, :max_years_for_age_check,
      :pool_size,
      :warn_timeout,
      :open_timeout,
      :read_timeout,
      :idle_timeout,
      :keep_alive

    def initialize
      @max_years_for_age_check = 100
      @mla_host = 'mla.dmdc.osd.mil'
      @mla_path = '/mla/single_record.xhtml'
      @pool_size = 10
      @warn_timeout = 0.25
      @open_timeout = 30
      @read_timeout = 30
      @idle_timeout = 300
      @keep_alive = 300
    end

  end

end
