class RepliesController < BaseController
  
  def create
    @reply = Reply.new(params[:reply])
    @reply.user = current_user
    @reply.save
    render_ajax @reply
  end

end
