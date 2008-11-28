# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'dccfbce14a5a0c9a81e557d288d2ba81'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  include AuthenticatedSystem
  
  protected
  
  before_filter :set_current_user
  def set_current_user
    User.current_user = current_user
  end

  def permission_denied
    flash[:notice] = "You don't have privileges to access this action"
    return(redirect_to root_url)
  end
  
  helper_method :add_js_files
  def add_js_files(*args)
    @included_javascript_files ||= ['prototype', 'application'];
    if args.size > 1
      args.each do |arg|
        add_js_files(arg);
      end
    else
      file = case args
      when Hash then url_for(args);
      else args;
      end
      @included_javascript_files << file unless @included_javascript_files.include?(file)
    end
  end
  
  helper_method :add_css_files
  def add_css_files(*args)
    @included_css_files ||= ['application'];
    if args.size > 1
      args.each do |arg|
        add_css_files(arg);
      end
    else
      file = case args
      when Hash then url_for(args);
      else args;
      end
      @included_css_files << file unless @included_css_files.include?(file)
    end
  end
end
