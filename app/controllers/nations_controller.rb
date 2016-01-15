class NationsController < ApplicationController
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
    @nation = Nation.find(params[:id])
    @nation.initialize_client
    @webhooks = @nation.client.call(:webhooks, :index)["results"]
    @webhooks_count = @webhooks.count
    @nation.update_webhooks_count(@webhooks_count)
  end
end
