class SchedulesController < ApplicationController
  def index
    if params[:team_ids]
      session[:team_ids] = params[:team_ids].split(/,/).map(&:to_i) || session[:team_ids]
    end
    get_team_urls

    case
      when @team_ids.nil?
        flash[:notice] = "Please select at least one team whose schedule you would like to follow"
        respond_to do |format|
          format.html{ redirect_to team_followers_path }
          format.json{ render :json => [] }
        end
        return
      when @team_ids.empty? && @team_urls.empty?
        flash[:notice] = "Please select at least one team whose schedule you would like to follow"
        respond_to do |format|
          format.html{ redirect_to team_followers_path }
          format.json{ render :json => [] }
        end
        return
      when !@team_ids.empty? && @team_urls.empty?
        flash[:notice] = "No active schedules for any of the selected teams"
        @schedule = @scheduled_dates = [ ]
      else
        urls = get_team_urls
        @schedule = ScheduleParserFactory.find( get_team_urls )
    end

    @advertisement = Advertisement.random_selection

    respond_to do |format|
      format.html{ 
        @scheduled_dates = @schedule.group_by{|item| item[:date] }
        render :action => :index
      }
      format.json{ 
        render :json => @schedule
      }
    end
  end

  private
    def get_team_ids
      @team_ids = current_user.team_ids || session[:team_ids]
    end

    def get_team_urls
      get_team_ids
      @team_urls = @team_ids.nil? ? [ ] : Team.find(@team_ids).map{|team| team.schedule_links.active.map{|link| HashWithIndifferentAccess.new(link.attributes)}}.flatten
    end
end
