require_relative 'test_helper'

class ResponseTest < Minitest::Test

  describe 'response' do

    def test_parse_response_with_good_pdf
      test_pdf64 = "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pVPWgJsy7d8TipDKDiDsy9NnP/n5TdVWGcLaGFivCLd6Esu9xhq2yeSzpVXXNYd4ghNGemF4lxyE0yg9ezRRJtr1WR1d6mKPcxzxKvG98+wXeArsBsbAX/ZxYLka0I55OrmPUX7YFzf2kI+3swCYo3nYf61UujBmVZSV3pRE2pT3MYYupcC4rG1oJD/3J/utDOmKCrPC4/5b1vRAm1rrO9qWu4ouIu+selYfa4JjFAplbmRzdHJlYW0KZW5kb2JqCjkgMCBvYmoKPDwvUGFyZW50IDYgMCBSL0NvbnRlbnRzIDggMCBSL1R5cGUvUGFnZS9SZXNvdXJjZXM8PC9Qcm9jU2V0IFsvUERGIC9UZXh0IC9JbWFnZUIgL0ltYWdlQyAvSW1hZ2VJXS9Gb250PDwvRjEgMiAwIFI+Pj4+L01lZGlhQm94WzAgMCA1OTUgODQyXT4+CmVuZG9iagoyIDAgb2JqCjw8L0Jhc2VGb250L0hlbHZldGljYS9UeXBlL0ZvbnQvRW5jb2RpbmcvV2luQW5zaUVuY29kaW5nL1N1YnR5cGUvVHlwZTE+PgplbmRvYmoKNiAwIG9iago8PC9JVFhUKDUuMi4xKS9UeXBlL1BhZ2VzL0NvdW50IDIvS2lkc1s3IDAgUiA5IDAgUl0+PgplbmRvYmoKMTAgMCBvYmoKPDwvVHlwZS9DYXRhbG9nL1BhZ2VzIDYgMCBSPj4KZW5kb2JqCjExIDAgb2JqCjw8L1Byb2R1Y2VyKGlUZXh0riA1LjIuMSCpMjAwMC0yMDEyIDFUM1hUIEJWQkEpL01vZERhdGUoRDoyMDE2MDQyMzE3NTQyOC0wNCcwMCcpL0NyZWF0aW9uRGF0ZShEOjIwMTYwNDIzMTc1NDI4LTA0JzAwJyk+PgplbmRvYmoKeHJlZgowIDEyCjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxNSAwMDAwMCBuIAowMDAwMDIxMDUwIDAwMDAwIG4gCjAwMDAwMTE3OTkgMDAwMDAgbiAKMDAwMDAxNzE5OCAwMDAwMCBuIAowMDAwMDE4NTI3IDAwMDAwIG4gCjAwMDAwMjExMzggMDAwMDAgbiAKMDAwMDAyMDQxOCAwMDAwMCBuIAowMDAwMDIwNjIwIDAwMDAwIG4gCjAwMDAwMjA4OTMgMDAwMDAgbiAKMDAwMDAyMTIwNyAwMDAwMCBuIAowMDAwMDIxMjUzIDAwMDAwIG4gCnRyYWlsZXIKPDwvUm9vdCAxMCAwIFIvSUQgWzxjZGFjNTE1NTgxYmFiMWY3N2E5MjU1NGE1NzI2YTY3MT48MGYxZGI3YzM1MGEzZmE3Nzg4MmNmNTM3YWUyYjRhMTk+XS9JbmZvIDExIDAgUi9TaXplIDEyPj4Kc3RhcnR4cmVmCjIxMzkwCiUlRU9GCg=="
      assert_equal MlaActiveDutyStatus::MLA_NOT_ACTIVE_DUTY, MlaActiveDutyStatus::Response.parse_response(Base64.strict_decode64(test_pdf64))
    end

    def test_parse_response_with_bad_pdf
      test_pdf = "%PDF-1.4\n%\xE2\xE3\xCF\xD3\n1 0"
      assert_equal MlaActiveDutyStatus::MLA_ERROR, MlaActiveDutyStatus::Response.parse_response(test_pdf)
    end

  end

end