class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    root_path
  end

  def redirect_unless_owner
    redirect_to root_path unless owner_signed_in?
    return
  end

end
