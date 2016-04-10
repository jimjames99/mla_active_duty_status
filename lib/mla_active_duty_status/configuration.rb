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
    attr_accessor :mla_single_record_url, :max_years_for_age_check

    def initialize
      @mla_single_record_url = 'https://mla.dmdc.osd.mil/single_record.xhtml'
      @max_years_for_age_check = 100
    end

  end

end
