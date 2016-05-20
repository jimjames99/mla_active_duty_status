require 'semantic_logger'
require 'mechanize'

module MlaActiveDutyStatus
  module Client

    include SemanticLogger::Loggable

    def self.call_mla_site(mla)
      browser = Mechanize.new do |agent|
        agent.open_timeout = MlaActiveDutyStatus.configuration.open_timeout
        agent.read_timeout = MlaActiveDutyStatus.configuration.read_timeout
        if MlaActiveDutyStatus.configuration.logging || (defined?(Rails) && Rails.env.development?)
          log = Logger.new('mechlog.log')
          log.level = Logger::DEBUG
          agent.log = log
        end
        agent.user_agent_alias = 'Mac Firefox'
      end
      if MlaActiveDutyStatus.configuration.ssl_verify
        browser.agent.http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        cert_store = OpenSSL::X509::Store.new
        if MlaActiveDutyStatus.configuration.ca_path
          ca_path = File.expand_path(MlaActiveDutyStatus.configuration.ca_path)
          cert_store.add_file ca_path
          browser.agent.http.cert_store = cert_store
        end
      else
        browser.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      host = MlaActiveDutyStatus.configuration.mla_host
      path = MlaActiveDutyStatus.configuration.mla_path
      browser.get("https://#{host}")
      page = browser.get("https://#{host}#{path}")
      mla_form = page.form('myForm')
      mla_form.ssn = mla.ssn
      mla_form.ssn2 = mla.ssn
      mla_form.dateOfBirth = mla.date_of_birth_usa
      mla_form.lastName = mla.last_name
      mla_form.firstName = mla.first_name
      mla_form.middleName = mla.middle_name
      page = browser.submit(mla_form, mla_form.buttons[1])
      pdf = page.body
      return Response.parse_response(pdf), pdf
    end

  end
end
