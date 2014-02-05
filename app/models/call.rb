class Call

  def info_set
    url = NSURL.URLWithString("http://49.212.87.13:3006/mobile/apis/token")
    response_ptr = Pointer.new(:object)
    error_ptr = Pointer.new(:object)
    req = NSURLRequest.requestWithURL(url)
    data = NSURLConnection.sendSynchronousRequest(req, returningResponse: response_ptr, error: error_ptr)
    if data
      httpResponse = response_ptr[0]
      if httpResponse.statusCode == 200
        capabilityToken = NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
        @device = TCDevice.alloc.initWithCapabilityToken(capabilityToken,delegate:nil)
      else
        errorString = NSString.stringWithFormat("HTTP status code %d",  httpResponse.statusCode)
        NSLog("Error logging in: %@", errorString)
      end
    else
      NSLog("Error logging in: %@", error.localizedDescription)
    end
    return self
  end

  def do
    info_set
    hash = {}
    _connection = @device.connect({"PhoneNumber" => "+819058932761"}, delegate:nil)
    _connection.retain
  end

end
