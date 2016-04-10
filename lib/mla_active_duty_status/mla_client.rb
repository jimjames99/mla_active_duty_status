require 'persistent_http'
require 'semantic_logger'

module MlaActiveDutyStatus
  module Client

    include SemanticLogger::Loggable

    # def self.config
    #   @config ||= begin
    #     if defined?(Rails)
    #       rails_env = Rails.env
    #     else
    #       rails_env = 'development'
    #     end
    #
    #     config_file = File.expand_path('../../../config/email_age.yml', __FILE__)
    #     full_config = YAML.load(ERB.new(File.read(config_file)).result(binding))
    #     env = ENV['EMAIL_AGE_ENV'] || rails_env
    #     config = full_config[env]
    #
    #     unless config
    #       raise "Invalid Email Age Service configuration, #{env} not specified" if defined?(Rails) && Rails.env.production?
    #       return nil
    #     end
    #
    #     persistent_http = PersistentHTTP.new(
    #       :name => 'EmailAgeService',
    #       :url => config[:base],
    #       :logger => logger,
    #       :pool_size => (config[:pool_size] || 10).to_i,
    #       :warn_timeout => (config[:warn_timeout] || 0.25).to_f,
    #       :open_timeout => (config[:open_timeout] || 30).to_f,
    #       :read_timeout => (config[:read_timeout] || 30).to_f,
    #       :idle_timeout => (config[:idle_timeout] || 300).to_f,
    #       :keep_alive => (config[:keep_alive] || 300).to_f,
    #       :force_retry => true,
    #       :proxy => :ENV,
    #       :debug_output => (rails_env == 'development' || ENV['CLARITY_HTTP_DEBUG']) ? $stdout : nil
    #     )
    #
    #     {
    #       :logger => logger,
    #       :persistent_http => persistent_http,
    #       :path => config[:path],
    #       :account_sid => config[:account_sid],
    #       :auth_token => config[:auth_token],
    #       :base => config[:base],
    #       :format => config[:format]
    #     }
    #   end
    # end
    #
    # def self.email_age(email=nil, ip = nil, params = {})
    #   if email.nil? && ip.nil?
    #     raise EmailAge::Error.new('Email Age Client Failure'), 'Email Age failure: Both email and IP input parameters are nil', caller
    #   else
    #     logger.measure_info '#email_age', metric: 'supplier/email_age/email_age_data' do
    #       @results = get_email_age_data(email, ip, params)
    #     end
    #     return @results
    #   end
    # end
    #
    # #######
    # private
    # #######
    #
    # def self.get_email_age_data(email=nil, ip=nil, params={})
    #
    #   query = [email, ip].compact.join('+')
    #   request_url = "#{config[:base]}#{config[:path]}"
    #   auth_url = OauthUrlUtility.new(request_url, config[:account_sid], config[:auth_token], config[:format], query, params).build_url
    #   parsed_url = URI.parse(auth_url)
    #   full_parsed_url = "#{parsed_url.scheme}://#{parsed_url.host}#{parsed_url.request_uri}"
    #
    #   config[:logger].debug { "Sending #{parsed_url.inspect} #{config[:persistent_http].host}:#{config[:persistent_http].port} thread=#{Thread.current}" }
    #   response = config[:persistent_http].request(Net::HTTP::Get.new(full_parsed_url))
    #   case response
    #     when Net::HTTPSuccess
    #       return Response.get_response(response.body)
    #     else
    #       message = "(#{response.code}) #{response.message}"
    #       raise EmailAge::Error.new(response), message, caller
    #   end
    # rescue StandardError => e
    #   message = "Email Age failure: #{e}"
    #   raise EmailAge::Error.new(e), message, caller
    # end

  end
end
