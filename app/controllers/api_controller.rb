class ApiController < ApplicationController
	protect_from_forgery :except => :update

	def index
		client = NationBuilder::Client.new(NATION_SLUG, API_KEY)
		@client = client.call(:webhooks, :index)
	end

	def update
		results = params[:api][:payload][:person_call][:person][:id]	
		person = {
				id: results,
				note: {
				content: "I made this with webhooks....WUTTTT"
					}
				}
		client = NationBuilder::Client.new(NATION_SLUG, API_KEY)
		client.call(:people, :private_note_create, person)
		render :text => results
	end


end
