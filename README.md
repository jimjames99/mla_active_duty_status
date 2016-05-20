# MlaActiveDutyStatus

![Travis badge](https://travis-ci.org/jimjames99/mla_active_duty_status.svg?branch=master) Tested on ruby 2.3.0 and jruby 1.7.

[![Gem Version](https://badge.fury.io/rb/mla_active_duty_status.svg)](https://badge.fury.io/rb/mla_active_duty_status)

The Military Lending Act requires lenders in certain situations to check the active duty status of the loan applicant. 
This gem uses [Mechanize](https://github.com/sparklemotion/mechanize) to screenscrape the MLA website providing the applicant details and returns a coded response for the active duty status
and the MLA PDF certificate.

MLA website:  `https://mla.dmdc.osd.mil`

Please note the MLA may change their site at any time, rendering this gem useless. 
Usage is at your own risk.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mla_active_duty_status'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mla_active_duty_status

## Usage

This gem can be run from the console with `rake console`.

The MLA requires the following details:
* last_name (required)
* first_name (optional)
* middle_name (optional)
* ssn (required)
* dob (required)

Create an applicant object:

```ruby
mla = MlaActiveDutyStatus::Applicant.new('Citizen', 'John', 'Q', '614223456',  '1950-01-25')
```

Check that the applicant details meet requirements:

```ruby
mla.valid?
````
This returns `true` or `false` and then you can view any validation errors:

```
mla.errors
=> ["last_name must be present", "date_of_birth must be within 100 years"]
```

Get the active duty status of the applicant:

```ruby
mla.active_duty_status
```

This returns an array of 2 values:
* status:

    0 = neither applicant nor spouse are active duty
    
    1 = applicant or spouse appears active duty
    
    7 = MLA service timeout or error
    
    9 = invalid or missing required fields

* pdf - a binary string of the Certificate


Response times are typically 1.0 - 3.0 seconds. This gem does not maintain a persistent connection across Rails' 
requests because Mechanize is not threadsafe. A future version will probably drop Mechanize for a 
pure [HTTP::Net::Persistent](http://docs.seattlerb.org/net-http-persistent/) implementation.

## Rubies

Currently tested against MRI 2.3.0 but anything > 1.9.2 should work.

Known [issue with jruby](https://github.com/sparklemotion/mechanize/issues/209) but the gem monkeypatches 
a fix until the issue is available in Mechanize.

## Certificates

The MLA site is part of the DoD and uses site certificates that you might not ordinarily have installed.

The MLA has [instructions for installing certificates](https://mla.dmdc.osd.mil/faq.xhtml#Q1), 
but you will most likely need to download the cert file to your production server and point to it like this:

```ruby
MlaActiveDutyStatus.configuration.ca_path = '/path/to/my/ca_cert.crt'
```

By default, this gem will use the java keystore on jruby.

It is highly recommended that you do NOT disable certificate verification, but if you need to debug a problem 
then set the configuration like this:

```ruby
MlaActiveDutyStatus.configuration.ssl_verify = false
```

## Configuration

Set value for configuration:
```ruby
MlaActiveDutyStatus.configuration.logging = true
```

* max_years_for_age_check - Ages older than this will be flagged as invalid.

* logging - if true or in Rails development environment will log to a local file called mechlog.log

Defaults:
```ruby
@max_years_for_age_check = 100
@mla_host = 'mla.dmdc.osd.mil'
@mla_path = '/mla/single_record.xhtml'
@ssl_verify = true
@ca_path = nil
@logging = false
@open_timeout = 10
@read_timeout = 10
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jimjames99/mla_active_duty_status. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to 
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

