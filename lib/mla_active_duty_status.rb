require 'mla_active_duty_status/version'
require 'mla_active_duty_status/configuration'
require 'mla_active_duty_status/applicant'
require 'mla_active_duty_status/client'
require 'mla_active_duty_status/response'
require 'date'

module MlaActiveDutyStatus

  self.configure
  MLA_NOT_ACTIVE_DUTY = 0 # neither applicant nor spouse are active duty
  MLA_ACTIVE_DUTY     = 1 # applicant or spouse appears active duty
  MLA_ERROR           = 7 # MLA service timeout or error
  MLA_INVALID         = 9 # invalid or missing required fields

end
