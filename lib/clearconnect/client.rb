module ClearConnect  
  ## 
  # This class is the interface to the ClearConnect API.
  # 
  # Authentication can be managed via configuration (see the documentation for ClearConnect::Configuration)
  # or by passing the username, password, and sitename for the Contingent Staffing user directly to the client
  # on initialization.
  #
  # example:
  #   client = ClearConnect::Client.new('username', 'password', 'sitename')
  #   client.get(action: 'getOrders') # => array of orders
  class Client
    def initialize(username = ClearConnect.configuration.username, 
                   password = ClearConnect.configuration.password, 
                   site_name = ClearConnect.configuration.site_name,
                   session = (ClearConnect.configuration and ClearConnect.configuration.session))
      # to ensure the endpoints are available
      if !ClearConnect.configuration
        ClearConnect.configure do |c|
          c.username = username
          c.password = password
          c.site_name = site_name
          c.session = session
        end
      end
      @username = username
      @password = password
      @session = session
    end

    def soap_client
      @soap_client ||= SoapClient.new(@username, @password)
      @soap_client
    end

    def rest_client
      @rest_client ||= RestClient.new(@username, @password)
      @rest_client
    end

    # alias for ClearConnect::RestClient#get_request
    def get(query)
      rest_client.get_request(query)
    end
    
    # alias for ClearConnect::SoapClient#post_request
    def post(query)
      soap_client.post_request(query)
    end

    # retrieves and sets session key for making requests, may raise
    # exception if there is an error.
    def get_session_key
      response = rest_client.get_no_session(
        action: 'getSessionKey').parsed_response[0]

      if response['success'] == "1"
        @sessionKey = response['sessionKey']
        rest_client.set_session_key @sessionKey
        # TODO: Incorporate sessions into Savon client.
        #@soap_client.set_session_key @sessionKey if @soap_client
      elsif response['errorCode']
        raise "Session key retrieval failed with code: #{response['errorCode']}."
      else
        raise "Session key retrieval failed for an unknown reason."
      end
    end
  end
end
