class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_current_user
  respond_to :html, :js


  def show
  	@user = User.find(params[:id])
  	@nations = @user.nations
  end

  private
    def redirect_if_not_current_user
      @user = User.find(params[:id])
        unless @user == current_user
          flash[:danger] = "You can't access that page.".html_safe
          redirect_to user_path(current_user)
        end
    end
end
