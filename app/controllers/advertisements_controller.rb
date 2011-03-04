class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.scoped :order => :company
  end

  def show
    @advertisement = Advertisement.random_selection

    respond_to do |format|
      format.html{ render :partial => 'show' }
    end
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
        format.html{ render :action => :new }
      end
    end
  end

  def edit
    @advertisement = current_user.account.advertisements.find params[:id]
    respond_to do |format|
      format.html{ render :action => :new }
    end
  end

  def update
    @advertisement = current_user.account.advertisements.find params[:id]
    respond_to do |format|
      if @advertisement.update_attributes params[:advertisement]
        format.html{ redirect_to advertisements_path }
      else
        flash[:error] = "The ad could not be saved for the following reasons:<br/>" << @advertisement.errors.full_messages.join('<br/>')
        format.html{ render :action => :new }
      end
    end
  end

  def destroy
    @advertisement = current_user.account.advertisements.find params[:id]
    @advertisement.destroy

    respond_to do |format|
      format.html{ redirect_to advertisements_path }
    end
  end
end
