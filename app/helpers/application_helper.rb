# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def user_auth_link
    if current_user
      link_to "Logout [#{current_user.login}]", logout_path
    else
      link_to "Login", login_path
    end
  end
  
  def render_comments(object = nil)
    render(:partial=> 'comments/comment', :collection => object.comments, :locals => { :max_level => 5 }, :spacer_template => 'comments/comments_divider') unless object.comments.empty?;
  end
  
  def javascript_files(partial = nil)
    add_js_files("#{params[:controller]}_#{params[:action]}");
    file_names = @controller.instance_variable_get('@included_javascript_files');
    if block_given?
      file_names.each do |file|
        concat(capture{yield(file)});
      end
    else
      if partial
        concat(capture{render(:partial => partial, :collection => file_names)});
      else
        file_names.each do |file|
          concat(capture{javascript_include_tag(file)+"\n"});
        end
      end
    end
  end
  
  def stylesheet_files(partial = nil)
    add_css_files("#{params[:controller]}_#{params[:action]}");
    file_names = @controller.instance_variable_get('@included_css_files');
    if block_given?
      file_names.each do |file|
        concat(capture{yield(file)});
      end
    else
      if partial
        concat(capture{render(:partial => partial, :collection => file_names)});
      else
        file_names.each do |file|
          concat(capture{stylesheet_link_tag(file)+"\n"});
        end
      end
    end
  end
end
