class SchedulesController < ApplicationController
  def index
    get_team_urls
    case
      when @team_ids.empty? && @team_urls.empty?
        flash[:notice] = "Please select at least one team whose schedule you would like to follow"
        redirect_to team_followers_path
      when !@team_ids.empty? && @team_urls.empty?
        flash[:notice] = "No active schedules for any of the selected teams"
        @schedule = @scheduled_dates = [ ]
      else
        @schedule = Schedule.find( get_team_urls )
        @scheduled_dates = @schedule.group_by{|item| item[:date] }
    end

    if @team_urls.empty?
    else
    end

    @advertisement = Advertisement.random_selection
  end

  private
  def get_team_urls
    @team_ids = current_user.team_ids || session[:team_ids]

    @team_urls = @team_ids.nil? ? [ ] : Team.find(@team_ids).map{|team| team.schedule_links.active.map{|link| HashWithIndifferentAccess.new(link.attributes)}}.flatten
  end
end
