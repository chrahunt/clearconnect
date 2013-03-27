class RestClient
  include HTTParty
  base_uri "https://agencystaffing.apihealthcare.com/flexnurse/clearConnect/2_0/index.cfm"
  default_params :resultType => 'json'
  format :json
  
  def initialize(username, password)
    self.class.default_params :username => username, :password => password
  end
  
  # Takes a query of the format { key: 'value', key2: 'value' } where the keys are symbols corresponding
  # to the parameters passed to the ClearConnect REST API
  def get_request(query)
    query = normalize_query(query)
    options = { :query => query }
    self.class.get("", options)
  end

  # Turns arguments that are arrays into comma-delimited strings
  def normalize_query(query)
    query.each_pair do |param, arg|
      if arg.is_a? Array
        query[param] = arg.join(',')
      end
    end
  end
end