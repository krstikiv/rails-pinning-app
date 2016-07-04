require 'spec_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user_with_boards)
	@pins = @user.pins
  end

  it "renders attributes in <p>" do
    render
    #expect(rendered).to match(/First Name/)
    #expect(rendered).to match(/Last Name/)
    #expect(rendered).to match(/Email/)
	
    @user.pins.each do |pin|
      expect(rendered).to match(pin.title)
    end
  end
end
