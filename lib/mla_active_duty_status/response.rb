module MlaActiveDutyStatus
  module Response

    require 'pdf/reader'

    # lines look like:
    #
    # Based on the information you provided DMDC does not possess information indicating that the individual is either on active duty for more than 30 days or a family member of a service member on active duty
    # or
    # Based on the information you provided DMDC does possess information indicating that the individual is either on active duty for more than 30 days or a family member of a service member on active duty
    #
    # Yes, the only difference is the presence of "not".
    #
    def self.parse_response(pdf)
      pdf.force_encoding('UTF-8')
      reader = PDF::Reader.new(StringIO.new(pdf))
      status_text =reader.pages.first.text.split("\n")[25]
      status_text.include?('not') ? MLA_NOT_ACTIVE_DUTY : MLA_ACTIVE_DUTY
    rescue
      MLA_ERROR
    end

  end
end
