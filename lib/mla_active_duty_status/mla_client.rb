require 'persistent_http'
require 'semantic_logger'

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

    def self.persistent_http
      PersistentHTTP.new(
        name: 'MlaActiveDutyStatus',
        url: MlaActiveDutyStatus.configuration.mla_single_record_url,
        logger: logger,
        pool_size: (config[:pool_size] || 10).to_i,
        warn_timeout: (MlaActiveDutyStatus.configuration.warn_timeout || 0.25).to_f,
        open_timeout: (MlaActiveDutyStatus.configuration.open_timeout || 30).to_f,
        read_timeout: (MlaActiveDutyStatus.configuration.read_timeout || 30).to_f,
        idle_timeout: (MlaActiveDutyStatus.configuration.idle_timeout || 300).to_f,
        keep_alive: (MlaActiveDutyStatus.configuration.keep_alive || 300).to_f,
        force_retry: true,
        proxy: :ENV,
        debug_output: (self.rails_env == 'development' || ENV['CLARITY_HTTP_DEBUG']) ? $stdout : nil
      )
    end

    def self.get_status(mla)
      logger.measure_info '#mla_active_duty_status', metric: 'supplier/mla/active_duty_status' do
        @results = get_status_data(mla)
      end
      return @results
    end

    private

    def self.get_status_data(mla)

      query = [email, ip].compact.join('+')
      request_url = "#{config[:base]}#{config[:path]}"
      parsed_url = URI.parse(auth_url)
      uri = URI.parse(persistent_http.url)

      config[:logger].debug { "Sending #{parsed_url.inspect} #{persistent_http.host}:#{persistent_http.port} thread=#{Thread.current}" }
      response = persistent_http.request(Net::HTTP::Post.new(full_parsed_url))
      case response
        when Net::HTTPSuccess
          return Response.get_response(response.body)
        else
          message = "(#{response.code}) #{response.message}"
          raise EmailAge::Error.new(response), message, caller
      end
    rescue StandardError => e
      message = "Email Age failure: #{e}"
      raise EmailAge::Error.new(e), message, caller
    end

  end
end
