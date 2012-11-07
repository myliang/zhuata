class CustomFailure < Devise::FailureApp
  def redirect_url
    puts ":::::::redirect_url::::"
    render :text => "{}"
  end
end
