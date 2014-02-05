class ReceiverList

  attr_accessor :date_and_time, :user_name

  def initialize(data)
    @date_and_time = data['date_and_time']
    @user_name = data['user_name']
  end
end
