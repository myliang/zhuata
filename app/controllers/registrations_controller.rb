class RegistrationsController < Devise::RegistrationsController

  prepend_before_filter :authenticate_scope!, 
    :only => [:edit, :edit_pwd, :edit_avatar, :update, :destroy]

  def edit; end
  def edit_pwd; end
  def edit_avatar; end

  def update
    if _update
      redirect_to :action => "edit"
    else
      _render_with_action :edit
    end
  end
  def update_pwd
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    # prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if resource.update_with_password(resource_params)
      # if is_navigational_format?
      #   flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
      #     :update_needs_confirmation : :updated
      #   set_flash_message :notice, flash_key
      # end
      sign_in resource_name, resource, :bypass => true
      # respond_with resource, :location => after_update_path_for(resource)
      redirect_to :action => "edit_pwd"
    else
      clean_up_passwords resource
      # respond_with resource
      _render_with_action :edit_pwd
    end

  end
  def update_avatar
    if _update
      redirect_to :action => "edit_avatar"
    else 
      _render_with_action :edit_avatar
    end
  end

  private
  def _update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    resource.update_attributes(resource_params)
  end

  def _render_with_action(action)
    params[:action] = action.to_s
    render action
  end

end
