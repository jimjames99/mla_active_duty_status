require_relative 'test_helper'

class ApplicantTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MlaActiveDutyStatus::VERSION
  end

  describe 'Applicant' do
    before do
      @mla = MlaActiveDutyStatus::Applicant.new('James', nil, nil, '123456789', '1950-02-02')
    end

    after do
      MlaActiveDutyStatus.reset
    end

    def test_create_valid_mla
      mla = MlaActiveDutyStatus::Applicant.new('James', nil, nil, '123456789', '1950-02-02')
      assert_equal true, mla.valid?
    end

    describe 'last_name validations' do
      def test_invalid_last_name
        mla = MlaActiveDutyStatus::Applicant.new(nil, nil, nil, '123456789', '1950-02-02')
        assert_equal false, mla.valid?
        assert_equal 'last_name must be present', mla.errors.join(',')
      end
    end

    describe 'date_of_birth validations' do
      def test_invalid_dob
        mla = MlaActiveDutyStatus::Applicant.new('James', nil, nil, '123456789', '1850-02-02')
        assert_equal false, mla.valid?
        assert_equal 'date_of_birth must be within 100 years', mla.errors.join(',')
      end

      def test_invalid_dob_years_range
        MlaActiveDutyStatus.configuration.max_years_for_age_check = 10
        mla = MlaActiveDutyStatus::Applicant.new('James', nil, nil, '123456789', '1950-02-02')
        assert_equal false, mla.valid?
        assert_equal 'date_of_birth must be within 10 years', mla.errors.join(',')
      end
    end

    # TODO add other validations.
  end
end
