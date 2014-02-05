class Client
#本体とのapi関連のやりとりは全てここに集約する

  BASE_URL = 'http://49.212.87.13:3006/mobile/apis/'

  class << self
    
    def fetch_receiver_lists(&block) 
      url = BASE_URL + 'reservation_lists'
      BW::HTTP.get(url) do |response|
        reservation_lists = []
        message = nil
        begin
          if response.ok?
            json = BW::JSON.parse(response.body.to_s)
            reservation_lists = json['reservation_lists'].map {|data| ReceiverList.new(data) }
          else
            if response.body.nil?
              message = response.error_message
            else
              json = BW::JSON.parse(response.body.to_s)
              message = json['error']
            end
          end
        rescue => e
          reservation_lists = []
          message = 'Error'
        end
        block.call(reservation_lists, message)
      end 
    end 
  end
end
