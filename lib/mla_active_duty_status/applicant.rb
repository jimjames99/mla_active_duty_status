require 'semantic_logger'

module MlaActiveDutyStatus
  class Applicant

    include SemanticLogger::Loggable

    attr_accessor :errors

    attr_reader :last_name, :first_name, :middle_name, :ssn, :date_of_birth, :date_of_birth_usa

    def initialize(last_name, first_name, middle_name, ssn, date_of_birth)
      @last_name = last_name.to_s.strip
      @first_name = first_name.to_s.strip
      @middle_name = middle_name.to_s.strip
      @ssn = ssn.to_s.strip.gsub(/\D/, '')
      @date_of_birth = date_of_birth
      @date_of_birth_usa = nil
      @errors = []
    end

    def valid?
      validate_args
      errors.empty?
    end

    def active_duty_status
      logger.measure_info '#mla_active_duty_status', metric: 'supplier/mla/active_duty_status' do
        if !self.valid?
          return status = MLA_INVALID, pdf = nil
          exit
        end
        status, pdf = MlaActiveDutyStatus::Client.call_mla_site(self)
      end
    rescue Timeout::Error
      return status = MLA_ERROR, pdf = nil
    end

    def file_format
      sprintf('%9s', @ssn) + @date_of_birth.strftime('%Y%m%d') + sprintf('%-26.26s', @last_name) + sprintf('%-20.20s', @first_name) + sprintf('%-20.20s', @middle_name) + sprintf('%-28.28s', '')
    end

    private

    def validate_args
      validate_last_name
      validate_ssn
      validate_date_of_birth
    end

    def validate_last_name
      errors << 'last_name must be present' if @last_name.empty?
    end

    def validate_ssn
      errors << 'ssn must be present' if @ssn.empty?
      errors << 'ssn must be 9 digits' unless @ssn.length == 9
    end

    def validate_date_of_birth
      @date_of_birth = Date.parse(@date_of_birth.to_s)
      errors << "date_of_birth must be within #{MlaActiveDutyStatus.configuration.max_years_for_age_check} years" if @date_of_birth < (Date.today << (MlaActiveDutyStatus.configuration.max_years_for_age_check * 12))
      @date_of_birth_usa = @date_of_birth.strftime('%m/%d/%Y')
    rescue ArgumentError
      errors << 'date_of_birth not valid date'
    end

  end
end
