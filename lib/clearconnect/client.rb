module ClearConnect  
  class Client
    def initialize(username = ClearConnect.configuration.username, 
                   password = ClearConnect.configuration.password, 
                   site_name = ClearConnect.configuration.site_name)
      @username = username
      @password = password
    end

    def soap_client
      @soap_client ||= SoapClient.new(@username, @password)
    end

    def rest_client
      @rest_client ||= RestClient.new(@username, @password)
    end

    # See RestClient.get_request
    def get(query)
      rest_client.get_request(query)
    end
    
    # See SOAPClient.post_request
    def post(query)
      soap_client.post_request(query)
    end
  end
end