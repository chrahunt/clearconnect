module ClearConnect  
  # the client class is the interface to the ClearConnect API.
  # 
  # authentication can be managed via configuration (see the documentation for ClearConnect::Configuration)
  # or by passing the username, password, and sitename for the Contingent Staffing user directly to the client
  # on initialization.
  #
  # example:
  #   client = ClearConnect::Client.new('username', 'password', 'sitename')
  #   client.get(action: 'getOrders') # => array of orders
  class Client
    def initialize(username = ClearConnect.configuration.username, 
                   password = ClearConnect.configuration.password, 
                   site_name = ClearConnect.configuration.site_name)
      # to ensure the endpoints are available
      if !ClearConnect.configuration
        ClearConnect.configure do |c|
          c.username = username
          c.password = password
          c.site_name = site_name
        end
      end
      @username = username
      @password = password
    end

    def soap_client
      @soap_client ||= SoapClient.new(@username, @password)
    end

    def rest_client
      @rest_client ||= RestClient.new(@username, @password)
    end

    # alias for ClearConnect::RestClient#get_request
    def get(query)
      rest_client.get_request(query)
    end
    
    # alias for ClearConnect::SoapClient#post_request
    def post(query)
      soap_client.post_request(query)
    end
  end
end