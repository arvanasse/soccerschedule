class DashboardsController < ApplicationController
  layout 'mobile'

  def show
    logger.info "The environment is #{Rails.env}"

    respond_to do |format|
      format.html
    end
  end

end
