class SchedulesController < ApplicationController
  def index
    get_team_urls
    if @team_urls.empty?
      @scheduled_dates = [ ]
    else
      @schedule = Schedule.find( get_team_urls )
      @scheduled_dates = @schedule.group_by{|item| item[:date] }
    end
  end

  private
  def get_team_urls
    team_ids = current_user.team_ids || session[:team_ids]  

    @team_urls = team_ids.nil? ? [ ] : Team.find(team_ids).map{|team| HashWithIndifferentAccess.new(team.attributes) }
  end
end
