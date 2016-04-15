require 'semantic_logger'
require 'mechanize'

module MlaActiveDutyStatus
  module Client

    include SemanticLogger::Loggable

    def self.rails_env
      if defined?(Rails)
        Rails.env
      else
        'development'
      end
    end

    def self.get_status(mla)
      logger.measure_info '#mla_active_duty_status', metric: 'supplier/mla/active_duty_status' do
        @results = get_status_data(mla)
      end
      @results
    end

 #   private

    def self.get_status_data(mla)
      start = Time.now
      agent = Mechanize.new
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
      page.save_as page.filename
      puts "Saved as #{page.filename}"
      pdf = page.body
      status = Response.parse_response(pdf)
    rescue Exception => e
    ensure
      elapsed = Time.now - start
      return mla.valid?, status, pdf, e
    end

  end
end
