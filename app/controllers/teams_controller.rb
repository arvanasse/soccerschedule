class TeamsController < ApplicationController
  def index
    @teams = Team.scoped(:order=>:name)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new params[:team]
    respond_to do |format|
      if @team.save
        format.html{ redirect_to teams_path }
      else
        render :action=>:new
      end
    end
  end

  def edit
    @team = Team.find params[:id]
  end

  def update
    @team = Team.find params[:id]
    respond_to do |format|
      if @team.update_attributes params[:team]
        format.html{ redirect_to teams_path }
      else
        format.html{ render :action => :edit }
      end
    end
  end

  def destroy
    @team = Team.find params[:id]
    @team.destroy

    respond_to do |format|
      format.html{ redirect_to teams_path }
    end
  end
end
