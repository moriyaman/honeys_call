class CallController < UIViewController
  
  def viewDidLoad
    super
    #電話中を表示する部分
    self.view.backgroundColor = UIColor.whiteColor
    image = UIImage.imageNamed("026_05.png")
    @image_view = UIImageView.alloc.initWithImage(image)
    @image_view.frame = CGRectMake(10, 10, 300, 300)

    gradient = CAGradientLayer.layer
    gradient.frame = view.bounds
    gradient.colors = [UIColor.blackColor.CGColor, UIColor.whiteColor.CGColor]

    @hangup_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @hangup_button.setTitle("hang up", forState:UIControlStateNormal)
    @hangup_button.sizeToFit
    boundsSize = self.view.bounds.size
    @hangup_button.center = CGPointMake((boundsSize.width/2)-60,(boundsSize.height/2)+100 )
    @hangup_button.addTarget(self, action:'hangup', forControlEvents:UIControlEventTouchUpInside)
    @hangup_button.styleClass = 'hangup_btn'
    
    self.view.layer.addSublayer(gradient)
    self.view.addSubview @image_view
    self.view.addSubview @hangup_button
    self.view.addSubview @label

    #電話をかけている部分
    #call_info_set
    #hash = {}
    #@connection = @device.connect({"PhoneNumber" => "+819058932761"}, delegate:nil)
    #@connection.retain
  end

  def call_info_set
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

  def hangup
    #@connection.disconnect
    #@connection.release
    #@connection = nil

      @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      reservation_lists_controller = ReservationListsController.new
      navigation_controller = UINavigationController.alloc.initWithRootViewController(reservation_lists_controller)
      mypage_controller = MypageController.new
      settings_controller = SettingsController.new
      tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
      tab_controller.viewControllers = [navigation_controller, mypage_controller, settings_controller]
      @window.rootViewController = tab_controller
      @window.makeKeyAndVisible
      true
  end

end
