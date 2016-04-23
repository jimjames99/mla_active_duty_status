# MlaActiveDutyStatus

The Military Lending Act requires lenders in certain situations to check the active duty status of the loan applicant. 
This gem screenscrapes the MLA website providing the applicant details and returns a coded response for the active duty status
and the MLA PDF certificate.

Please note the MLA may change their site at any time, rendering this gem useless. 
Also usage is at your own risk.

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

The MLA requires the following details:
* last_name (required)
* first_name 
* middle_name
* ssn (required)
* dob (required)

Create an applicant object:

````
mla = MlaActiveDutyStatus::Applicant.new(
  last_name: 'Doolittle', 
  first_name: 'Alfred', 
  middle_name: 'A', 
  ssn: '614223456', 
  date_of_birth: '1950-01-25')
````

Check that the applicant details meet requirements:

````
mla.valid?
````
This returns `true` or `false` and then you can view any validation errors:

````
mla.errors
=> ["last_name must be present", "date_of_birth must be within 100 years"]
````

Get the active duty status of the applicant:

````
mla.active_duty_status
````

This returns an array of 2 values:
* status:

    0 = neither applicant nor spouse are active duty
    
    1 = applicant or spouse appears active duty
    
    7 = MLA service timeout or error
    
    9 = invalid or missing required fields

* pdf - a binary string of the Certificate


Response times are typically 1.0 - 3.0 seconds. This gem does not maintain a persistent connection for multiple requests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jimjames99/mla_active_duty_status. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

