class DashboardsController < ApplicationController
  def show
    respond_to do |format|
      format.html{ render :action=>:show, :layout => false }
    end
  end

end
