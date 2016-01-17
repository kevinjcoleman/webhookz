class NationsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_current_user

  def new
  end

  def index
  end

  def create
  end

  def update
  end

  def destroy
  end

  def edit
  end

  def show
    begin
      @user = User.find(params[:user_id])
      @nation = Nation.find(params[:id])
      @nation.initialize_client
      @webhooks = @nation.client.call(:webhooks, :index)["results"]
      @nation.save
    rescue
      flash[:danger] = "That nation's api isn't working, FIX IT!"
      redirect_to user_path(@user)
    end
  end

  private
    def redirect_if_not_current_user
      @user = User.find(params[:user_id])
        unless @user == current_user
          flash[:danger] = "You can't access that page."
          redirect_to user_path(current_user)
        end
    end
end
