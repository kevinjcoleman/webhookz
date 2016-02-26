require 'rails_helper'

RSpec.describe TrelloWebhooksController, :type => :controller do

  describe "GET freeimport_response" do
    it "returns http success" do
      get :freeimport_response
      expect(response).to be_success
    end
  end

end
