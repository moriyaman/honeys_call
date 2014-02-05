class UserController < UIViewController
  # ビューが読み込まれた後で実行されるメソッド
  def viewDidLoad
   super
    @tag = 'User Info'
    self.title = @tag # ナビゲーションバーのタイトルを変更
    self.view.backgroundColor = UIColor.whiteColor
    @call_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @call_button.setTitle("call", forState:UIControlStateNormal)
    @call_button.sizeToFit

    boundsSize = self.view.bounds.size
    @call_button.center = CGPointMake((boundsSize.width/2)-75, (boundsSize.height/2)+50 )
    @call_button.addTarget(self, action:'call', forControlEvents:UIControlEventTouchUpInside)
    @call_button.styleClass = 'call_btn'

    @info_back_view = UIView.alloc.initWithFrame(CGRectMake(20, 20, 270, 200))
    @info_back_view.backgroundColor = UIColor.colorWithRed(0.439, green:0.502, blue:0.565, alpha:1.000)
    @info_back_view.layer.cornerRadius = 5;
    @info_back_view.clipsToBounds = true; 
    @info_back_view.styleClass = 'back' 

    image = UIImage.imageNamed("oka.png")
    @image_view = UIImageView.alloc.initWithImage(image)
    @image_view.frame = CGRectMake(30, 30)
    @image_view.styleClass = 'user_img'
    self.view.addSubview @info_back_view
    self.view.addSubview @image_view
    self.view.addSubview @call_button
  end

  def call
    call_controller = CallController.alloc.initWithNibName(nil, bundle: nil)
    self.navigationController.pushViewController(call_controller, animated: true)
  end

end
