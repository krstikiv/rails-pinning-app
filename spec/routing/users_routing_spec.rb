require 'spec_helper'

RSpec.describe UsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/users").to route_to("users#index")
    end

    it "routes to #new" do
      expect(:get => "/users/new").to route_to("users#new")
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to("users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/users/1/edit").to route_to("users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/users").to route_to("users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/users/1").to route_to("users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/users/1").to route_to("users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/users/1").to route_to("users#destroy", :id => "1")
    end

  end

  describe "GET login" do
    it "renders the login view" do
      get('login')
      expect(response).to render_template("login")
    end
  end

  describe "POST login" do
    before(:all) do
      @user = User.create(email: "coder@skillcrush.com", password: "secret")
      @valid_user_hash = {email: @user.email, password: @user.password}
      @invalid_user_hash = {email: "", password: ""}
    end

    after(:all) do
      if !@user.destroyed?
        @user.destroy
      end
    end
    it "renders the show view if params valid" do
      user = User.create! valid_attributes
      post :authenticate, {email: user.email, password: user.password}
      #user = User.authenticate(@valid_user_hash[:email], @valid_user_hash[:password])
      expect(response).to redirect_to(user_path(user.id))
    end

    it "populates @user if params valid" do
      user = User.create! valid_attributes
      post :authenticate, valid_attributes
      expect(assigns(:user)).to eq(user)
    end

    it "renders the login view if the params are invalid" do
      user = User.create! valid_attributes
      post :authenticate, invalid_attributes
      expect(response).to render_template("login")
    end

    it "populates the @errors variable if params are invalid" do
      user = User.create! valid_attributes
      post :authenticate, invalid_attributes
      expect(assigns[:errors].present?).to be(true)
    end
  end
end
