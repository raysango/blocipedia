class WikisController < ApplicationController
  respond_to :html, :js
  def index
    @user = current_user
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
    @user = current_user
  end

  def edit
    @collaborator = Collaborator.new
    @user = current_user
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def show
    @user = current_user
    @wiki = Wiki.find(params[:id])
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated"
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the Wiki"
      render :edit
    end
  end
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end
  
  def create
    @wiki = current_user.wikis.new(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki is saved"
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the Wiki"
      render :new
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notce] = "Wiki was deleted"
    else
      flash[:error] = "There was an error deleting the Wiki"
    end
    respond_with(@wiki) do |format|
       format.html { redirect_to wikis_path }
     end
  end
end
