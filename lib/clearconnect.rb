require 'httparty'
require 'savon'
require 'xmlsimple'
require 'json'

# require other files
module ClearConnect
  class NoFunctionError < StandardError; end
  class AuthenticateError < StandardError; end
end

require 'clearconnect/client'
require 'clearconnect/configuration'
require 'clearconnect/rest_client'
require 'clearconnect/soap_client'