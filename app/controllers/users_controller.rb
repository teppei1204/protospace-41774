class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @Prototype = @user.prototypes
  end
end
