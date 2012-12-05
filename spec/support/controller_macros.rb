module ControllerMacros
  def login_admin
    request.env["devise.mapping"] = Devise.mappings[:admin]
    admin = FactoryGirl.create(:admin) # Using factory girl as an example
    sign_in admin
  end

  def login_user
    request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in user
    user
  end
end
