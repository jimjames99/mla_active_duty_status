require 'mla_active_duty_status/version'
require 'mla_active_duty_status/configuration'
require 'mla_active_duty_status/applicant'
require 'mla_active_duty_status/client'
require 'mla_active_duty_status/response'
require 'date'

module MlaActiveDutyStatus

  self.configure
  MLA_NOT_ACTIVE_DUTY = 0 # neither applicant nor spouse are active duty
  MLA_ACTIVE_DUTY     = 1 # applicant or spouse appears active duty
  MLA_ERROR           = 7 # MLA service timeout or error
  MLA_INVALID         = 9 # invalid or missing required fields

end

# Monkeypatch Mechanize for jruby until their gem is fixed.
# Issue: https://github.com/sparklemotion/mechanize/issues/209
class Mechanize::Util

  def self.html_unescape(s)
    return s unless s
    s.gsub(/&(\w+|#[0-9]+);/) { |match|
      number = case match
                 when /&(\w+);/
                   Mechanize.html_parser::NamedCharacters[$1]
                 when /&#([0-9]+);/
                   $1.to_i
               end

      number ? ([number].pack('U') rescue match) : match
    }
  end

  case NKF::BINARY
    when Encoding
      def self.guess_encoding(src)
        NKF.guess(src) || Encoding::UTF_8
      end
    else
      # Old NKF from 1.8, still bundled with JRuby and Rubinius
      NKF_ENCODING_MAP = {
        NKF::UNKNOWN => Encoding::US_ASCII,
        NKF::BINARY  => Encoding::ASCII_8BIT,
        NKF::ASCII   => Encoding::US_ASCII,
        NKF::JIS     => Encoding::ISO_2022_JP,
        NKF::EUC     => Encoding::EUC_JP,
        NKF::SJIS    => Encoding::Shift_JIS,
        NKF::UTF8    => Encoding::UTF_8,
        NKF::UTF16   => Encoding::UTF_16BE,
        NKF::UTF32   => Encoding::UTF_32BE,
      }

      def self.guess_encoding(src)
        NKF_ENCODING_MAP[NKF.guess(src)]
      end
  end

end
