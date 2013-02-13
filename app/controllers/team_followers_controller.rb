class TeamFollowersController < ApplicationController
  before_filter :render_mobile, :only => :index

  def index
    team_ids = current_user.team_ids || session[:team_ids]
    @team_ids = team_ids.nil? ? [ ] : team_ids.map(&:to_i) 
    @teams = Team.scoped :order => 'classification_id, name',
                         :conditions => { :state => 'visible' }
  end

  def create
    respond_to do |format|
      format.html{ 
        team_ids = params[:team_follower].collect do |team_id, team_attr|
          team_attr[:team_id] != '0' ? team_id : nil
        end
        team_ids.compact!

        session[:team_ids] = team_ids

        unless params[:user].blank? || params[:user][:email].blank?
          user = User.new params[:user]
          UserSession.create(params[:user_session].merge(:email => user.email, :password=>user.password) ) if user.save
        end

        unless current_user.is_a? Guest
          current_user.team_ids = team_ids
        end

        redirect_to schedules_path 
      }
      format.json{
        if session[:team_ids].nil?
          session[:team_ids] = current_user.is_a?(Guest) ? [ ] : current_user.team_ids
        end

        Rails.logger.info "Added #{params[:team_follower][:team_id]} to #{session[:team_ids]}"

        session[:team_ids] << params[:team_follower][:team_id].to_i
        session[:team_ids].uniq!
        Rails.logger.info "Team ids are now #{session[:team_ids].to_sentence}"

        unless current_user.is_a? Guest
          current_user.team_ids = session[:team_ids]
        end
        render :json => { :success => true }
      }
    end
  end

  def destroy
    if session[:team_ids].nil?  
      session[:team_ids] = current_user.is_a?(Guest) ? [ ] : current_user.team_ids
    end
    Rails.logger.info "Removed #{params[:team_follower][:team_id]} from #{session[:team_ids]}"

    session[:team_ids].delete params[:id].to_i
    Rails.logger.info "Team ids are now #{session[:team_ids].to_sentence}"

    unless current_user.is_a? Guest
      current_user.team_ids = session[:team_ids]
    end

    render :json => { :success => true }
  end
end
