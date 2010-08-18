class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.scoped :order => :company
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = current_user.account.advertisements.build params[:advertisement]

    respond_to do |format|
      if @advertisement.save
        format.html{ redirect_to advertisements_path }
      else
        flash[:error] = "The ad could not be saved for the following reasons:<br/>" << @advertisement.errors.full_messages.join('<br/>')
        logger.debug @advertisement.errors.full_messages.to_sentence
        format.html{ render :action => :new }
      end
    end
  end
end
