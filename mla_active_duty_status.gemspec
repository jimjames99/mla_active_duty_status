# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mla_active_duty_status/version'

Gem::Specification.new do |spec|
  spec.name          = 'mla_active_duty_status'
  spec.version       = MlaActiveDutyStatus::VERSION
  spec.authors       = ['jimjames99']
  spec.email         = ['jim@jimjames.org']

  spec.summary       = %q{Calls mla.dmdc.osd.mil Single Record Request page to get active duty status.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'TODO: Put your gems website or public repo URL here.'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency 'semantic_logger'
  spec.add_dependency 'pdf-reader'
  spec.add_dependency 'mechanize'
end


# mla = MLA.new(last_name: 'JAMES',
#   first_name: 'xx',
#   middle_name: 'xx',
#   ssn: '614058902',
#   dob: '1960-01-25')
# if mla.valid?
#   # wrap this in a minion...
#   valid, military_status, pdf, error = mla.perform
# else
#   puts mla.errors
# end
# or put it on a minion
# required: last_name, ssn, dob
# valid boolean, true if no problems and known military_status is returned.
# military_status returns
# 0 = neither applicant nor spouse are active duty
# 1 = applicant or spouse appears active duty
# pdf return binary object
# error returns text like:
# service timeout
# service not available
# SSN not present or not well formed
# date not valid or missing
# last_name blank

# Config
# dob to be in last 100 years or config date.
# PDF parser?
