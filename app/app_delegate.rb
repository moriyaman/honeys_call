class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    user = User.get_info
    User.get_country_code unless user.country_code 
    
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    unless user.logined? 
     #未ログインならログイン画面へ
      @navigation_controller = UINavigationController.alloc.initWithRootViewController(SessionsController.alloc.init)
      @window.rootViewController = @navigation_controller
    else
     #ログイン済みならそのまま
      reservation_lists_controller = ReservationListsController.new
      navigation_controller = UINavigationController.alloc.initWithRootViewController(reservation_lists_controller)
      navigation_controller.navigationBar.tintColor = UIColor.colorWithRed(0.29, green:0.29, blue:0.29, alpha:1.000)
      mypage_controller = MypageController.new
      settings_controller = SettingsController.new
      tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
      tab_controller.viewControllers = [navigation_controller, mypage_controller, settings_controller]
      @window.rootViewController = tab_controller
    end 
    @window.makeKeyAndVisible
    true
  end
end
