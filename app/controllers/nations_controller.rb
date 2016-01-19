class NationsController < ApplicationController
  before_action :authenticate_user!, except: [:cancel]
  before_action :redirect_if_not_current_user, except: [:cancel]
  before_action :find_nation, only: [:show, :update, :destroy, :edit]
  before_action :all_nations, only: [:create, :destroy, :update]
  before_action :user_find, only: [:cancel]
  respond_to :html, :js

  def new
    @nation = Nation.new
    @submit_title = "Create nation"
    respond_to do |format|
      format.js
      format.html { render nothing: true  }
    end
  end

  def index
  end

  def create
    @nation = Nation.new(nation_slug: nation_params[:nation_slug], api_key: nation_params[:api_key], user: @user)
    @result = @nation.save
    respond_to do |format|
      if @result
        format.js { flash.now[:notice] = "<strong>#{@nation.nation_slug}</strong> was created!" }
        format.html { render nothing: true  }
      else
        format.js 
        format.html { render nothing: true  }
      end
    end
  end

  def update
    @result = @nation.update_attributes(nation_slug: nation_params[:nation_slug], api_key: nation_params[:api_key])
    respond_to do |format|
      if @result
        format.js { flash.now[:notice] = "<strong>#{@nation.nation_slug}</strong> was succesfully saved!" }
        format.html { render nothing: true  }
      else
        format.js { flash.now[:danger] = "<strong>Something went wrong</strong>" }
        format.html { render nothing: true  }
      end
    end
  end

  def destroy
    @result = @nation.destroy
    respond_to do |format|
      if @result
          format.js { flash.now[:danger] = "<strong>#{@nation.nation_slug}</strong> was deleted!" }
          format.html { render nothing: true  }
        else
          format.js { flash.now[:danger] = "<strong>Something went wrong</strong>" }
          format.html { render nothing: true  }
      end
    end
  end

  def edit
    @submit_title = "Edit nation"
    @nation.api_key = @nation.decrypt
    respond_to do |format|
      format.js
      format.html { render nothing: true  }
    end
  end

  def cancel
    respond_to do |format|
      format.js
      format.html { render nothing: true  }
    end
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
      params[:user][:nation]
    end

    def all_nations
      @nations = @user.nations
    end

    def user_find
      @user = User.find(params[:user_id])
    end
end
