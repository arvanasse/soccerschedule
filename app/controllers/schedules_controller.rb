class SchedulesController < ApplicationController
  def index
    @schedule = Schedule.find( get_team_urls )
    @scheduled_dates = @schedule.group_by{|item| item[:date] }
  end

  private
  def get_team_urls
    team_ids = current_user.team_ids || session[:team_ids]  

    @team_urls = team_ids.nil? ? [ ] : Team.find(team_ids).map{|team| HashWithIndifferentAccess.new(team.attributes) }
  end
end
