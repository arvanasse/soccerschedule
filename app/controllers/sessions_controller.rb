class SessionsController < ApplicationController
  def new
    
  end

  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      redirect_to schedules_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to schedules_path
  end

end
