# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def user_auth_link
    if current_user
      link_to "Logout", logout_path
    else
      link_to "Login", login_path
    end
  end
end
