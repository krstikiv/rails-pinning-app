class PinsController < ApplicationController
  before_action :get_pin, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show, :show_by_name]

  def index
   @pins = Pin.all

  end

  def show
    @users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id)
  end

  def new
    @pin = Pin.new
  end

  def edit
  end

  def update
    if @pin.update_attributes(pin_params)
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :edit
    end
  end

  def create
    @pin = Pin.create(pin_params)

    if @pin.valid?
      @pin.save
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :new
    end
  end

  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    @users = User.joins(:pinnings).where("users.id = ? or pinnings.pin_id = ?", @pin.user_id, @pin.id)
    render :show
  end

  def repin
  @pin = Pin.find(params[:id])
  @pin.pinnings.create(user: current_user)
  redirect_to user_path(current_user)
end  

  private
  # Use callbacks to share common setup or constraints between actions.
  def get_pin
    @pin = Pin.find(params[:id])
  end

  def pin_params
    params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
  end

end
