module MlaActiveDutyStatus
  class Applicant

    attr_accessor :errors

    def initialize(last_name:, first_name: nil, middle_name: nil, ssn:, date_of_birth:)
      @last_name = last_name.to_s.strip
      @first_name = first_name.to_s.strip
      @middle_name = middle_name.to_s.strip
      @ssn = ssn.to_s.strip.gsub(/\D/, '')
      @date_of_birth = date_of_birth
      @errors = []
      validate_args
    end

    def valid?
      errors.empty?
    end

    def get_mla_status
      exception_message = 'MLA Active Duty Status failure: Invalid applicant data. Review instance validation errors.'
      raise(MlaActiveDutyStatus::Error.new('MLA Active Duty Status failure'), exception_message, caller) unless self.valid?
      MlaActiveDutyStatus::Client.get_status(self)
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
      puts "CHECK: #{MlaActiveDutyStatus.configuration.max_years_for_age_check}"
      errors << "date_of_birth must be within #{MlaActiveDutyStatus.configuration.max_years_for_age_check} years" if @date_of_birth < (Date.today << (MlaActiveDutyStatus.configuration.max_years_for_age_check * 12))
    rescue ArgumentError
      errors << 'date_of_birth not valid date'
    end

  end
end
