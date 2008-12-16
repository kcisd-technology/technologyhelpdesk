class JavascriptsController < ApplicationController
  def system
    @root_path = Rails.env=='production' ? "/helpdesk" : '';
  end

end
