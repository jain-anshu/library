require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "gets all the users" do 
      post "/users", :params => { :user => {:username => "testuser1"} }
      post "/users", :params => { :user => {:username => "testuser2"} }
      get "/users"
      expect(JSON.parse(response.body).length).to eq(2)
      expect(JSON.parse(response.body).first["username"]).to eq("testuser1")
      expect(JSON.parse(response.body).second["username"]).to eq("testuser2")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show/:id" do
    it "gets the user with user id in params" do
      post "/users", :params => { :user => {:username => "testuser1"} }
      id = User.first.id
      get "/users/#{id}"
      expect(JSON.parse(response.body)["username"]).to eq("testuser1")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update/:id" do
    it "updates the user with user id in params" do
      post "/users", :params => { :user => {:username => "testuser5"} }
      id = User.first.id
      put "/users/#{id}", :params => {:user => {:username => "testuser2"}}
      expect(JSON.parse(response.body)['msg']).to eq("Updated the details in user 1")
    end
  end

  describe "POST /create" do
    it "creates a user with the attributes in the request body" do
      post "/users", :params => { :user => {:username => "testuser123"} }
      expect(JSON.parse(response.body)['msg']).to eq("User created successfully")
      expect(response).to have_http_status(:created)

    end

    it "gives an error if a username is not specified" do
      post "/users", :params => { :user => {:name => "badusername"} }
      expect(JSON.parse(response.body)[0]).to eq("Username can't be blank")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
