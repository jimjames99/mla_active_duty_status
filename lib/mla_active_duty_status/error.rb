module MlaActiveDutyStatus
  class Error < StandardError
    attr_reader :data

    def initialize(data)
      super
      @data = data
    end

  end

end
