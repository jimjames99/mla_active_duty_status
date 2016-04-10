require 'mla_active_duty_status/version'
require 'date'

class MlaActiveDutyStatus

  attr_accessor :errors

  def initialize(last_name:, first_name: nil, middle_name: nil, ssn:, date_of_birth:)
    @last_name = last_name.to_s.strip
    @first_name = first_name.to_s.strip
    @middle_name = middle_name.to_s.strip
    @ssn = ssn.to_s.strip.gsub(/\D/,'')
    @date_of_birth = date_of_birth
    @errors = []
    validate_args
  end

  def valid?
    errors.empty?
  end

  def perform

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
    errors << 'date_of_birth must be within 100 years' if @date_of_birth < (Date.today << (100 * 12))
  rescue ArgumentError
    errors << 'date_of_birth not valid date'
  end

end
