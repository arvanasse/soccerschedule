class SessionsController < ApplicationController
  def new
    
  end

  def create
    @user_session = UserSession.new params[:user_session]
    
    respond_to do |format|
      if @user_session.save

        @user_session.methods.sort.each{|m| logger.info m}

        format.html{ redirect_to schedules_path }
        format.json{ render :json => { :success => true, :user => @user_session.record.name, :team_ids => @user_session.record.team_ids } }
      else
        format.html{ render :action => :new }
        format.json{ render :json => { :success => false } }
      end
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to schedules_path
  end

end
