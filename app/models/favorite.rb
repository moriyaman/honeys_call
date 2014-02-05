class Favorite
#本体とのapi関連のやりとりは全てここに集約する

  class << self
    def create(from_user_id, to_user_id)
      url = BASE_URL + 'create_favorite'
      BW::HTTP.post(url, payload: {tel:tell, password: password} ) do |response|
        if response.ok?
          p "ok"
        end
      end 
    end
  end
end
