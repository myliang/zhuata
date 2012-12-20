class MessagesController < BaseController

  before_filter :authenticate_user!

  def unread
    params[:state] = 0
    to
  end

  def to
    params[:to_user_id] = current_user.id
    index
    render :index
  end

  def from
    params[:from_user_id] = current_user.id
    index
    render :index
  end

  def create
    @message = Message.new(params[:message])
    @message.from_user = current_user
    @message.save
    respond_with @message
  end

end
