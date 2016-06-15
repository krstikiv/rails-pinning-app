require 'spec_helper'
RSpec.describe PinsController do

	describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: "rails"}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
  end

  describe "GET edit" do
      before(:each) do
      @pin = Pin.find(1)
      end
      #responds with success
    it 'responds with successfully' do
      get :edit, id: @pin.id
      expect(response.success?).to be(true)
    end
        #renders the edit template
    it 'renders the edit view' do
     get :edit, id: @pin.id      
      expect(response).to render_template(:edit)
    end
      #assigns an instance variable called @pin to the Pin with the appropriate id
    it 'assigns an instance variable @pin to the Pin' do
      get :edit, id: @pin.id 
      expect(assigns(:pin)).to eq(@pin)
    end
  end

  describe "PUT update" do
    before(:each) do
      @pin = Pin.find(1)
      @pin_hash = { 
        title: "Rails Wizard",
        url: "http://railswizard.org",
        slug: "rails-wizard",
        text: "A fun and helpful Rails Resource",
        category_id: "1"
        }
      @error_hash = {
        title: nil,
        url: 1,
        slug: 3,
        text: 2,
        category_id: nil
       }
    end
  
  it 'responds with success' do
      put :update, id: @pin.id, pin: @pin_hash 
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
  
  it 'updates a pin' do
    put :update, id: @pin.id, pin: @pin_hash
    expect(Pin.find(@pin.id).present?).to be(true)
  end
  
  it 'redirects to the show view' do
      put :update, id: @pin.id, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
  
  it 'redisplays edit on error' do
      # Need to pass in an error of Pin
      # using my @error_hash
            
      put :update, id: @pin.id, pin: @error_hash
      expect(response).to render_template(:edit)
    end
    
    it 'assigns the @errors instance variable on error' do
      # Need to pass in an error of Pin
      # using my @error_hash
      
      put :update, id: @pin.id, pin: @error_hash
      expect(assigns[:errors].present?).to be(true)
    end
    
     
  end
end