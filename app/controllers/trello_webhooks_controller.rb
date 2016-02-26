class TrelloWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?

  def freeimport_response
  	trello_webhook = params[:trello_webhook]
  	action_type = params[:trello_webhook][:action][:type]
		if action_type == "createCard"
  		@board_name = params[:trello_webhook][:model][:name]
  		@card_name = params[:trello_webhook][:action][:data][:card][:name] 
  		@creator = params[:trello_webhook][:action][:memberCreator][:fullName]
  		FreeImportMailer.trello_notication_email(@board_name, @card_name, @creator).deliver_now
  	end
  	redirect_to root_path
  end

  def freeimport_landing

  end

   def json_request?
    request.format.json?
  end
end
