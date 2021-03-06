class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]
  before_action :validateUser, only: [ :edit, :update, :destroy]
  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @added = Hash.new
    @added["added"] = false
    @added["buyer"] = nil
    @inquiry = Inquiry.new
    @buyer = Buyer.new
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)
    if @house.company_id == nil
      flash[:error] = "Please assign a company to your profile."
      render :new
      return
    end
    respond_to do |format|
      if @house.save
        format.html {redirect_to @house, notice: 'House was successfully created.'}
        format.json {render :show, status: :created, location: @house}
      else
        format.html {render :new}
        format.json {render json: @house.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html {redirect_to @house, notice: 'House was successfully updated.'}
        format.json {render :show, status: :ok, location: @house}
      else
        format.html {render :edit}
        format.json {render json: @house.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html {redirect_to houses_url, notice: 'House was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_house
    @house = House.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def house_params
    params.require(:house).permit(:user_id, :company_id, :location, :size, :year, :style, :price, :floors, :basement, :owner, :contact , :image)
  end

  def validateUser
    if user_signed_in? && !(current_user.is_admin || current_user.id == @house.user_id)
      respond_to do |format|
        format.html {redirect_to home_index_path}
        return
      end
    end
  end
end
