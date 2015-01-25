class CollaboratorsController < ApplicationController
  before_action :wiki_id_find, except: [:index]
  
  def wiki_id_find
    @wiki = Wiki.find(params[:wiki_id])
  end
    
  def new
    @users = User.where(role: "premium")
    @collaborator = Collaborator.new
  end
  
  def create
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
  
  private
  
  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end
