class RestClient
  include HTTParty
  
  def initialize(username, password)
    self.class.base_uri ClearConnect.configuration.endpoints[:clearconnect]
    self.class.default_params :resultType => ClearConnect.configuration.format.to_s
    self.class.format ClearConnect.configuration.format
    @username = username
    @password = password
    @session = false
    @sessionKey = nil
  end
  
  # Takes a query of the format { key: 'value', key2: 'value' } where the keys are symbols corresponding
  # to the parameters passed to the ClearConnect REST API
  def get_request(query)
    if @session and @sessionKey.nil?
      raise "Invalid session key. You must first acquire a session key by calling 'get_session_key' before executing requests."
    elsif not @session
      query = normalize_query(query.merge(:sessionKey => @sessionKey))
      options = { :query => query }
      self.class.get("", options)
    else
      get_no_session(query)
    end
  end

  def get_no_session(query)
    query = normalize_query(query.merge(:username => @username, :password => @password))
    options = { :query => query }
    self.class.get("", options)
  end

  def set_session_key(key)
    puts "Setting session key: #{key}."
    @session = true
    @sessionKey = key
  end

  private
  # Turns arguments that are arrays into comma-delimited strings
  def normalize_query(query)
    query.each_pair do |param, arg|
      if arg.is_a? Array
        query[param] = arg.join(',')
      end
    end
  end
end
