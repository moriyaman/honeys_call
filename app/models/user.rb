class User
  
  # 各種設定の名前
  Properties = %w(id first_name last_name tel password country_code)

  # getter、setterを動的に生成
  Properties.each do |name|
    define_method("#{name}=") do |v|
      App::Persistence[name] = v
    end
    define_method("#{name}") do
      App::Persistence[name]
    end
  end

  def logined?
    return tel ? true : false
  end

  class << self
    def get_info
      self.new
    end

    def get_country_code
      url = BASE_URL + 'get_country_code'
      BW::HTTP.get(url) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_s)
          user = self.get_info
          user.country_code = json['country_code']
        else
          result = false
          alert = UIAlertView.alloc.initWithTitle("error", message: "Check your Network condition!", delegate:self, cancelButtonTitle:nil, otherButtonTitles: "ok", nil)
          alert.show
          true
        end
      end
    end

    def verified(tell, accept_token)
      url = BASE_URL + 'verified'
      BW::HTTP.post(url, payload: {tel:tell, accept_token: accept_token} ) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_s)
          if json['result']
            #認証成功
            user = self.new
            user.first_name= json['user']['first_name']
            user.last_name= json['user']['last_name']
            user.tel= json['user']['tel']
          else
            #認証失敗
            user = self.new
            user.first_name= nil
            user.last_name= nil
            user.tel= nil
            @result= false
            alert = UIAlertView.alloc.initWithTitle("error", message: json['error_msg'], delegate:self, cancelButtonTitle:nil, otherButtonTitles: "ok", nil)
            alert.show
          end
        end
      end 
      user = User.get_info
      return user.logined?
    end
 
  end

end
