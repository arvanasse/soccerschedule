class DashboardsController < ApplicationController
  layout 'mobile'

  def show
    respond_to do |format|
      format.html #
      format.mobile{ render :template => 'dashboards/show' }
    end
  end

end
