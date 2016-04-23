require 'semantic_logger'
require 'mechanize'

module MlaActiveDutyStatus
  module Client

    include SemanticLogger::Loggable

    def self.call_mla_site(mla)
      agent = Mechanize.new do |agent|
        agent.open_timeout = 3
        agent.read_timeout = 3
      end
      host = MlaActiveDutyStatus.configuration.mla_host
      path = MlaActiveDutyStatus.configuration.mla_path
      page = agent.get("https://#{host}#{path}")
      mla_form = page.form('myForm')
      mla_form.ssn = mla.ssn
      mla_form.ssn2 = mla.ssn
      mla_form.dateOfBirth = mla.date_of_birth_usa
      mla_form.lastName = mla.last_name
      mla_form.firstName = mla.first_name
      mla_form.middleName = mla.first_name
      page = agent.submit(mla_form, mla_form.buttons[1])
      # page.save_as page.filename
      # puts "Saved as #{page.filename}"
      pdf = page.body
      return Response.parse_response(pdf), 'PDF GOES HERE' # pdf
    end

  end
end

# mla = MlaActiveDutyStatus::Applicant.new(last_name: 'Doolittle', first_name: 'Gordon', middle_name: 'A', ssn: '614058902', date_of_birth: '1960-01-25')