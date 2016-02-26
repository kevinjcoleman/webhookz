class TrelloWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def freeimport_response
  	trello_webhook = params[:freeimport_response]
  	action_type = params[:freeimport_response][:action][:type]
		if action_type == "createCard"
  		@board_name = params[:freeimport_response][:model][:name]
  		@card_name = params[:freeimport_response][:action][:data][:card][:name] 
  		@creator = params[:freeimport_response][:action][:memberCreator][:fullName]
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
