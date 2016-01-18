class NationsController < ApplicationController
  before_action :authenticate_user!, except: [:cancel]
  before_action :redirect_if_not_current_user, except: [:cancel]
  before_action :find_nation, only: [:show, :update, :destroy, :edit]
  before_action :all_nations, only: [:create, :destroy]
  respond_to :html, :js

  def new
    @nation = Nation.new
    @submit_title = "Create nation"
  end

  def index
  end

  def create
    @nation = Nation.create(nation_slug: nation_params[:nation_slug], api_key: nation_params[:api_key], user: @user)
  end

  def update
  end

  def destroy
    @nation.destroy
  end

  def edit
    @submit_title = "Edit nation"
  end

  def cancel
  end

  def show
    begin
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

    def find_nation 
      @nation = Nation.find(params[:id])
    end

    def nation_params
      params[:user][:nations]
    end

    def all_nations
      @nations = @user.nations
    end

    def user_find
      @user = User.find(params[:id])
    end
end
