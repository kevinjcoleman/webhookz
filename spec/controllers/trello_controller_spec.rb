require 'rails_helper'

RSpec.describe TrelloController, :type => :controller do

  describe "GET response" do
    it "returns http success" do
      get :response
      expect(response).to be_success
    end
  end

end
