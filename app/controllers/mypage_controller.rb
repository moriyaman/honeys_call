class MypageController < UIViewController

  def initWithNibName(name, bundle: bundle)
    super
    
    #カスタムでアレンジする際は下記を使う
    button = UIButton.alloc.init 
    button.setTitle(FontAwesome.icon("heart"), forState:UIControlStateNormal)
    button.titleLabel.font = FontAwesome.fontWithSize(25)
    button.setTitleColor(UIColor.orangeColor, forState:UIControlStateHighlighted)
    button.setTitleColor(UIColor.whiteColor, forState:UIControlStateNormal)
    button.sizeToFit
    self.tabBarItem = BW::UIBarButtonItem.custom(button) 

    #self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemContacts, tag: 1)
    self
  end

  # ビューが読み込まれた後で実行されるメソッド
  def viewDidLoad
    super
    self.title = 'Mypage'
  end

end
