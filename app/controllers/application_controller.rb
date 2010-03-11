# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password

  private
  def current_user
    if defined?(@current_user)
      @user_session = UserSession.new if @current_user.is_a?(Guest)
      return @current_user 
    end
    @current_user = ( current_user_session && current_user_session.user ) || Guest.new
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
end
