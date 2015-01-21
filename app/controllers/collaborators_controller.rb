class CollaboratorsController < ApplicationController
  def new
    @users = User.where(role: "premium")
    @collaborator = Collaborator.new
    @wiki = Wiki.find(params[:wiki_id])
  end
  
  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
  
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)
    if @collaborator.save
      flash[:notice] = "Successfully added collaborator."
      redirect_to :back
    else
      flash[:notice] = "There was an error."
      redirect_to :back
    end
  end
  
  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = Wiki.find(params[:wiki_id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was successfully removed."
      redirect_to action: :new
    else
      flash[:notice] = "Collaborator could not be removed."
    end
  end
    

  def index
    @collwikis = current_user.collaborators.pluck("wiki_id") 
    @wikis = current_user.wikis
  end

  def edit
  end

  def show
  end
end
