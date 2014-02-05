class InternationalNumber

  JP= "81××××××××"
  US= "1××××××××××"

  class << self
    def get
      user = User.get_info
      case user.country_code
      when "JP"
        return JP
      when "US"
        return US
      end
    end
  end
end
