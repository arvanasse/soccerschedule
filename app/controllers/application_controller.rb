class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user
  has_mobile_fu

  before_filter :record_user_agent

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

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

    def record_user_agent
      agent = UserAgent.find_or_create_by_name request.user_agent.to_s
      agent.update_attribute :count, agent.count + 1
    end

    def mobile_required?
      is_device?('iphone')  || is_device?('ipad') || is_device?('android')
    end

    def render_mobile
      redirect_to(dashboard_path) if mobile_required?
    end
end
