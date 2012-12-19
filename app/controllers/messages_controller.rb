class MessagesController < BaseController

  before_filter :authenticate_user!

  def to
    @messages = current_user.receive_messages
  end

  def from
    @messages = current_user.send_messages
  end

  def create
    @message = Message.new(params[:message])
    @message.from_user = current_user
    @message.save
    respond_with @message
  end

end
