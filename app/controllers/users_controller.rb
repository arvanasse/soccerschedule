class UsersController < ApplicationController
  def show
    @user = current_user
    @teams = Team.scoped(:order=>:name)
  end

  def guest
    @user = current_user
    @teams = Team.scoped(:order=>:name)

    respond_to do |format|
      format.html{ render :action=>:show }
    end
  end
end
