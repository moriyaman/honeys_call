class SettingsController < UITableViewController

  def initWithNibName(name, bundle: bundle)
    super
    
    #カスタムでアレンジする際は下記を使う
    #button = UIButton.alloc.init 
    #button.setTitle(FontAwesome.icon("key"), forState:UIControlStateNormal)
    #button.titleLabel.font = FontAwesome.fontWithSize(25)
    #button.setTitleColor(UIColor.orangeColor, forState:UIControlStateHighlighted)
    #button.setTitleColor(UIColor.whiteColor, forState:UIControlStateNormal)
    #button.sizeToFit
    #self.tabBarItem = BW::UIBarButtonItem.custom(button) 
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemContacts, tag: 1)
    self
  end

  # ビューが読み込まれた後で実行されるメソッド
  def viewDidLoad
    super
    self.title = 'Settings'
    @menu_lists=["hoge", "fuga", "hogehoge" ]
  end

  # テーブルの行数を返すメソッド
  def tableView(tableView, numberOfRowsInSection:section)
    @menu_lists.count
  end

  # テーブルのセルを返すメソッド
  CELL_ID = 'Reservation Lists'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CELL_ID)

    # ラベルをセット
    cell.textLabel.text = @menu_lists[indexPath.row]
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell
  end

  #セルをクリックした時のイベント
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
  end

end
