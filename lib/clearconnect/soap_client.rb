class SoapClient
  def initialize(username, password)
    wsdl = HTTParty.get("https://agencymedia001.apihealthcare.com/flexnurse/wsdl/staffingWebService.wsdl", :format => 'xml').parsed_response
    @client = Savon::Client.new(
      wsdl: wsdl, 
      ssl_verify_mode: :none,
      log_level: :info
    )
    @username = username
    @password = password
    @default_params = {
      :username => username,
      :password => password,
      :resultType => 'json'
    }
  end
  
  # Encodes request, packages into required node, sends, decodes response
  def generic_request(message)
    request = "<requestXmlString>#{xml_encode(message)}</requestXmlString>"
    response = @client.call(:tss_request, message: request)
    # :tss_request_response => {:tss_request_return => [ugly value to be decoded]}
    # response.body
    JSON.parse(response.body[:tss_request_response][:tss_request_return])[0]
  end

  # Takes a query of format { :key => 'value' } where :key is the properly formatted parameter and 'value' is the string value
  # Parameters can be nested like so: { :tempRecords => { :tempRecord => [ { :key1 = 'value1', :key2 => 'value2' }, { :key1 => 'value3' } ] } }
  # will produce <tempRecords><tempRecord><key1>value1</key1><key2>value2</key2></tempRecord><tempRecord><key1>value3</key1></tempRecord></tempRecords>
  def post_request(query)
    params = @default_params.merge(query)
    post_data = XmlSimple.xml_out(params, RootName: 'clearviewRequest', NoAttr: true)
    generic_request(post_data)
  end
  
  def xml_encode(xml_string)
    string = xml_string
    characters = [
      { find: '&', replacement: '&amp;' },
      { find: '"', replacement: '&quot;' },
      { find: '<', replacement: '&lt;' },
      { find: '>', replacement: '&gt;' },
      { find: "'", replacement: '&apos;' }
    ]
    characters.each do |set|
      new_string = string.gsub(set[:find], set[:replacement])
      if not new_string.nil?
        string = new_string
      end
    end
    return string 
  end

  def xml_decode(xml_string)
    string = xml_string
    characters = [
      { replacement: '&', find: '&amp;' },
      { replacement: '"', find: '&quot;' },
      { replacement: '<', find: '&lt;' },
      { replacement: '>', find: '&gt;' },
      { replacement: "'", find: '&apos;' }
    ]
    characters.each do |set|
      new_string = string.gsub(set[:find], set[:replacement])
      if not new_string.nil?
        string = new_string
      end
    end
    return string 
  end
end