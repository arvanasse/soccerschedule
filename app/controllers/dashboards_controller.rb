class DashboardsController < ApplicationController
  layout 'mobile'

  def show
    respond_to do |format|
      format.html
    end
  end

end
