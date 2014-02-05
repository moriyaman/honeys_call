class ReservationListsController < UITableViewController
  # ビューが読み込まれた後で実行されるメソッド
  def viewDidLoad
    super
    
    @tag = 'Reciever List'
    self.title = @tag # ナビゲーションバーのタイトルを変更
    @reservation_lists = [] # 取得したエントリをこのインスタンス変数に格納
    
    if @refreshHeaderView == nil
      @view = EGORefreshTableHeaderView.alloc.initWithFrame(CGRectMake( 0, 0 - self.tableView.bounds.size.height, self.view.frame.size.width, 
                self.tableView.bounds.size.height ))
      @view.delegate = self
      self.tableView.addSubview(@view)
      @refreshHeaderView = @view
    end
    
    @refreshHeaderView.refreshLastUpdatedDate
    table_reload
  end

  def table_reload
    Client.fetch_receiver_lists do |reservation_lists,error_message| 
      if error_message.nil?  
        @reservation_lists = reservation_lists
        self.tableView.reloadData # テーブルをリロード
      else
       p error_message
      end
    end
  end

  # テーブルの行数を返すメソッド
  def tableView(tableView, numberOfRowsInSection:section)
    @reservation_lists.count
  end

  # テーブルのセルを返すメソッド
  CELL_ID = 'Reservation Lists'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) || begin
      cell = CustomCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CELL_ID)
      cell.createLabels
      cell
    end
    reservation_list = @reservation_lists[indexPath.row]
    #cell.backgroundColor = UIColor.colorWithRed(0.961, green:0.961, blue:0.961, alpha:1.000) 

    cell.primaryLabel.text = "#{reservation_list.date_and_time}"
    cell.secondaryLabel.text = "#{reservation_list.user_name}"
    cell
  end

  #セルをクリックした時のイベント
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    reservation_list = @reservation_lists[indexPath.row]
    user_controller = UserController.alloc.initWithNibName(nil, bundle: nil)
    self.navigationController.pushViewController(user_controller, animated: true)
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    return 70
  end

  def scrollViewDidScroll(scrollView)
    @refreshHeaderView.egoRefreshScrollViewDidScroll(scrollView)
  end

  def scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    @refreshHeaderView.egoRefreshScrollViewDidEndDragging(scrollView)
  end

  def egoRefreshTableHeaderDidTriggerRefresh(view)
    @reloading = true
    queue = NSOperationQueue.alloc.init
    queue.addOperationWithBlock(->{
      NSThread.sleepForTimeInterval(3)
      self.tableView.reloadData 
      #更新完了
      NSOperationQueue.mainQueue.addOperationWithBlock(->{
        self.doneLoadingTableViewData
        table_reload
      })
    })
  end

  def doneLoadingTableViewData
    @reloading = false
    @refreshHeaderView.egoRefreshScrollViewDataSourceDidFinishedLoading(self.tableView)
  end

  def egoRefreshTableHeaderDataSourceIsLoading(view)
    return @reloading
  end

  def egoRefreshTableHeaderDataSourceLastUpdated(view)
    return NSDate.date
  end

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemMostViewed, tag: 1)
    self
  end


end

