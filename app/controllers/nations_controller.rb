class NationsController < ApplicationController
  before_action :authenticate_user!

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
end
