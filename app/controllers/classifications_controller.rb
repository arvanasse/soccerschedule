class ClassificationsController < ApplicationController
  def index
    @classifications = Classification.order(:name)

    respond_to do |format|
      format.json{ render :json => @classifications.to_json(:include=>:teams) }
    end
  end
end
