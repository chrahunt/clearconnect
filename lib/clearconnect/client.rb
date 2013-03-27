module ClearConnect  
  class Client
    def initialize(username = ClearConnect::Config.username, password = ClearConnect::Config.password)
      @username = username
      @password = password
      #@rest_client = RestClient.new(username, password)
      #@soap_client = SoapClient.new(username, password)
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