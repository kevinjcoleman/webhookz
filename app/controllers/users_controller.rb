class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@nations = @user.nations
  end
end
