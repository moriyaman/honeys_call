class SessionsController < Formotion::FormController

  def init
    international_number = InternationalNumber.get
    @form = Formotion::Form.new({
    sections: [{
      title: "Register",
      rows: [{
        title: "International Tel",
        key: :tel,
        placeholder: international_number,
        type: :string,
        auto_correction: :no,
        auto_capitalization: :none
      }]
    }, {
      rows: [{
        title: "Confirm",
        type: :submit
      }]
    }]
    })

    @form.on_submit do |form|
      create_authorization_code
    end

    initWithForm(@form)
  end

  def authorization_form
    @form = Formotion::Form.new({
    sections: [{
      title: "Enter Authorization Code",
      rows: [{
        title: "code",
        key: :accept_token,
        placeholder: "required",
        type: :string,
        secure: true
      }]
    }, {
      rows: [{
        title: "Confirm",
        type: :submit
      }]
    }]
    })

    @form.on_submit do |form|
      verified
    end

    initWithForm(@form)
  end

  # ビューが読み込まれた後で実行されるメソッド
  def viewDidLoad
    super
    self.title = 'Register' # ナビゲーションバーのタイトルを変更
  end

  def create_authorization_code
    form = @form.render
    #tel = form[:tel]
    Account.create("+819058932761")
    user = User.get_info
    user.tel = "+819058932761" 
    authorization_form 
    form_controller = Formotion::FormController.alloc.initWithForm(@form) 
    self.navigationController.pushViewController(form_controller, animated: true)
  end

  def verified
    form = @form.render 
    user = User.get_info
    result = User.verified("+819058932761", form[:accept_token])
    if result
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

end
