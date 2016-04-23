require_relative 'test_helper'

class ClientTest < Minitest::Test

  describe 'client' do

    # Makes a live call so it needs internet access.
    def test_actual_call
      mla = MlaActiveDutyStatus::Applicant.new('James', nil, nil, '123456789', '1950-02-02', nil)
      assert_equal MlaActiveDutyStatus::MLA_NOT_ACTIVE_DUTY, mla.active_duty_status.first
    end

  end

end
