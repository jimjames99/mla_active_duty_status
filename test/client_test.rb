require_relative 'test_helper'

class ClientTest < Minitest::Test

  describe 'client' do

    # Makes a live call so it needs internet access.
    def test_actual_call
      # TODO check that release and prod have certs.
      mla = MlaActiveDutyStatus::Applicant.new('James', nil, nil, '123456789', '1950-02-02', nil)
      # Turn off cert checks in test because Travis will not have CA certs.
      # TODO Fix this by adding current DoD CA certs to gem.
      MlaActiveDutyStatus.configuration.ssl_verify = false
      assert_equal MlaActiveDutyStatus::MLA_NOT_ACTIVE_DUTY, mla.active_duty_status.first
    end

  end

end
