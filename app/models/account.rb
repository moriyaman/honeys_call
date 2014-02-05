class Account < User
 
  class << self
    def create(tel)
      url = BASE_URL + 'create_account'
      BW::HTTP.post(url, payload: {tel: tel} ) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_s)
          if json['result']
            alert = UIAlertView.alloc.initWithTitle("complete", message: json['msg'], delegate:self, cancelButtonTitle:nil, otherButtonTitles: "ok", nil)
            alert.show
            true
          else
            #ログイン失敗
            alert = UIAlertView.alloc.initWithTitle("error", message: json['error_msg'], delegate:self, cancelButtonTitle:nil, otherButtonTitles: "ok", nil)
            alert.show
            false
          end
        end
      end
    end
  end
end
