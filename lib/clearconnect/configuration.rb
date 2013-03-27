module ClearConnect
  class Configuration
    attr_accessor \
      :username,
      :password,
      :site_name,
      :endpoints,
      :mode,
      :format

    def initialize
      @username = nil
      @password = nil
      @site_name = nil
      @format = :json
      @mode = :no_session
      @endpoints = nil
    end

    def site_name=(site_name)
      @site_name = site_name
    end

    # Does endpoints need to be set at any point?
    def endpoints
      @endpoints ||= {
        clearconnect: "https://agencystaffing.apihealthcare.com/#{@site_name}/clearConnect/2_0/index.cfm",
        wsdl: "https://agencymedia001.apihealthcare.com/#{@site_name}/wsdl/staffingWebService.wsdl"
      }
    end

    # I don't think this is necessary
    def endpoints=(options = {})
      if options.nil? 
        @endpoints
      end
      @endpoints = options
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
    puts configuration.inspect
  end
end