class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:edit, :update, :destroy, :show]
  before_action :move_to_index, except: [:edit, :update, :destroy]


  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
      redirect_to @prototype
    else
      render :new
    end
  end




  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless user_signed_in?
      redirect_to @prototype
    end
  end

  def update
      @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to @prototype
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end


  private
  
  def prototype_params
    params.require(:prototype).permit(:image, :text).merge(user_id: current_user.id)
  end
end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
