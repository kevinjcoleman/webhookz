class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_current_user


  def show
  	@user = User.find(params[:id])
  	@nations = @user.nations
  end


end
