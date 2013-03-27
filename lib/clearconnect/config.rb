module ClearConnect
  module Config
    
    class << self
      attr_accessor :username
      attr_accessor :password
      attr_accessor :site_name
      attr_accessor :endpoints
      attr_accessor :mode
    end

    self.endpoints = {
      clearconnect: "https://agencystaffing.apihealthcare.com/#{site_name}/clearConnect/2_0/index.cfm",
      wsdl: "https://agencymedia001.apihealthcare.com/#{site_name}/wsdl/staffingWebService.wsdl"
    }
    self.username = nil
    self.password = nil
    self.mode = :no_session
  end
end