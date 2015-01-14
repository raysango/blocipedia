class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def show
    @wiki = Wiki.find(params[:id])
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated"
      render :show
    else
      flash[:error] = "There was an error updating the Wiki"
      render :edit
    end
  end
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
  def create
    @wiki = Wiki.new(wiki_params)
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
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the Wiki"
      render :show
    end
  end
end
