class WebhookController < ApplicationController
  def create
  	@user = User.find(params[:user_id])
  	@nation = Nation.find(params[:nation_id])
  	@result = @nation.webhook_create(webhook_params)
  	@webhook = @nation.webhooks.last
  	@nations = @user.nations
  	respond_to do |format|
  		if @result
	      format.js { flash.now[:notice] = "#{@nation.nation_slug}'s <strong>#{@webhook.normalized_event}</strong> webhook was created!" }
	      format.html { render nothing: true  }
	 	 else
		      format.js { flash.now[:danger] = "Something went wrong when creating a <em>#{@webhook.normalized_event}</em> webhook for <strong>#{@nation.nation_slug}</strong>!" }
		      format.html { render nothing: true  }
	 	 end
    end
  end

  def new
  	@user = User.find(params[:user_id])
  	@nation = Nation.find(params[:nation_id])
  	@webhook = Webhook.new

  	respond_to do |format|
      format.js
      format.html { render nothing: true  }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @nation = Nation.find(params[:nation_id])
    @webhook = Webhook.find(params[:id])

    respond_to do |format|
      format.js
      format.html { render nothing: true  }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @nation = Nation.find(params[:nation_id])
    @webhook = Webhook.find(params[:id])

    @result = @nation.destroy_webhook(@webhook)
    @nations = @user.nations
    respond_to do |format|
      if @result
        format.js { flash.now[:notice] = "<strong>#{@nation.nation_slug.capitalize}'s</strong> <em>'#{@webhook.normalized_event}'</em> webhook was destroyed!" }
        format.html { render nothing: true  }
     else
        format.js { flash.now[:danger] = "Something went wrong when destroying <em>#{@webhook.normalized_event}</em> webhook for <strong>#{@nation.nation_slug}</strong>!" }
        format.html { render nothing: true  }
     end
    end
  end

  def cancel
    @user = User.find(params[:user_id])
    @nation = Nation.find(params[:id])

    respond_to do |format|
      format.js
      format.html { render nothing: true  }
    end
  end

  	private
	
		def webhook_params
			params[:user][:webhook][:event]
		end
end