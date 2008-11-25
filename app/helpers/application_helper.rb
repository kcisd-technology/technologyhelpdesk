# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def user_auth_link
    if current_user
      link_to "Logout [#{current_user.login}]", logout_path
    else
      link_to "Login", login_path
    end
  end
  
  def javascript_files
    add_js_files("#{params[:controller]}_#{params[:action]}");
    file_names = @controller.instance_variable_get('@included_javascript_files');
    if block_given?
      file_names.each do |file|
        concat(capture{yield(file)});
      end
    else
      file_names.each do |file|
        concat(javascript_include_tag(file));
      end
    end
  end
end
