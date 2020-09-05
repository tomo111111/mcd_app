require 'rails_helper'

RSpec.describe "Inventries", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/inventries/index"
      expect(response).to have_http_status(:success)
    end
  end

end
