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
    attr_accessor :mla_host, :mla_path, :max_years_for_age_check, :ssl_verify, :ca_path

    def initialize
      @max_years_for_age_check = 100
      @mla_host = 'mla.dmdc.osd.mil'
      @mla_path = '/mla/single_record.xhtml'
      @ssl_verify = true
      @ca_path = ''
    end

  end

end
