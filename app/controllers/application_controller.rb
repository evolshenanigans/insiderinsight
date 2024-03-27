class ApplicationController < ActionController::Base


protected
  def after_sign_in_path_for(resource)
    welcome_index_path
  end

end
