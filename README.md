Usage
-----

The ClearConnect gem all starts with `ClearConnect::Client`. Initialize
a client and then you can access the ClearConnect API methods via
`Client#get` and `Client#post`. Pass all parameters to these methods
as hashes, and make sure to include the action parameter to specify the
API method to invoke. When a call is completed successfully, a plain
Ruby structure (Array/Hash) with the retrieved information (or 
confirmation information) is returned.

```ruby
client = ClearConnect::Client.new('myname', 'mypassword', 'sitename')
client.get(action: 'getTemps', tempIdIn: 1000)
# => [{"tempId"=>"1000", "homeRegion"=>"1", ...}]
```

Add/Update requests are no more difficult to execute than the get
request demonstrated above. The Ruby structure passed to the method is
converted directly to XML which is sent to the API endpoint. Take the
`insertWorkHistory` API method as an example. Since it requires a root
node of `workHistoryRecords` with multiple `workHistoryRecord`
sub-nodes, we would construct a call to this method as follows:

```ruby
data = {
  workHistoryRecords: [
    { workHistoryRecord: {
      tempId: 1000,
      facility: 'Previous Employer 1',
      startDate: '2013-04-09',
      endDate: '2014-01-01'
    }}
  ]
}
client.post(action: 'insertWorkHistory', workHistoryRecords: data)
```

Configure
---------

The username, password, and sitename to use for authentication can be
configured in a few ways. When used in a larger project with
centralized configuration (e.g. a Rails application), the class method
`ClearConnect#configure` allows you to set the information that will be
used to authenticate the ClearConnect clients created. As an example, 
you may create the file `config/initializers/clearconnect.rb` with the
content:

```ruby
ClearConnect.configure do |config|
  config.username = ENV['cc_username']
  config.password = ENV['cc_password']
  config.site_name = ENV['cc_sitename']
end
```

In smaller applications or scripts, it may be easier to pass the info
via the constructor of the `ClearConnect::Client`, like so:

```ruby
client = ClearConnect::Client.new('username', 'password', 'sitename')
```

Notes
-----

The `#get` method of `ClearConnect::Client` uses the http client library
[HTTParty](https://github.com/jnunemaker/httparty). The `#post` method
uses the SOAP client [Savon](https://github.com/savonrb/savon). The
Savon client used internally is initialized when the first call is made
that requires it because the initialization can take some time, but
requests use the cached Savon client thereafter.

Issues
------

Since the endpoint for the ClearConnect API uses SSL (i.e. is accessed
via an https url), you may encounter the error `OpenSSL certificate
verify failed`. The solution for this is relatively simple, and can be
found [here](http://railsapps.github.io/openssl-certificate-verify-failed.html).
