class TeamFollowersController < ApplicationController
  def index
    team_ids = current_user.team_ids || session[:team_ids]
    @team_ids = team_ids.nil? ? [ ] : team_ids.map(&:to_i) 
    @teams = Team.scoped :order => :name
  end

  def create
    team_ids = params[:team_follower].collect do |team_id, team_attr|
      team_attr[:team_id] != '0' ? team_id : nil
    end
    team_ids.compact!

    session[:team_ids] = team_ids

    unless current_user.is_a? Guest
      current_user.team_ids = team_ids
    end

    respond_to do |format|
      format.html{ redirect_to schedules_path }
    end
  end
end