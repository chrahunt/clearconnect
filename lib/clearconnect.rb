require 'httparty'
require 'savon'
require 'xmlsimple'
require 'json'

# the clearconnect gem handles authentication and message passing between a 
# Ruby/Rails application and the ClearConnect API offered by API Healthcare
# as a supplement to their Contingent Staffing software.
module ClearConnect
  class NoFunctionError < StandardError; end
  class AuthenticateError < StandardError; end
end

require 'clearconnect/client'
require 'clearconnect/configuration'
require 'clearconnect/rest_client'
require 'clearconnect/soap_client'
require 'clearconnect/version'
