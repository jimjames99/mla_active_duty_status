require_relative 'test_helper'

class ClientTest < Minitest::Test

  describe 'client' do

    # Makes a live call so it needs internet access.
    def test_actual_call
      skip 'not working on travis'
      mla = MlaActiveDutyStatus::Applicant.new(
        last_name: 'Doolittle',
        first_name: 'Alfred',
        middle_name: 'A',
        ssn: '614223456',
        date_of_birth: '1950-01-25')
      assert_equal MlaActiveDutyStatus::MLA_NOT_ACTIVE_DUTY, mla.active_duty_status.first
    end

  end

end
