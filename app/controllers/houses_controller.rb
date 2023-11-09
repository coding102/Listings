class HouseController < ApplicationController
  #before any actions authenticate user
  before_action :authenticate_user!
  before_action :set_house, only: [:show, :update]

  def index      #GET /houses || /houses.json
    category = params[:category]
    search = params[:search]

    @houses = House.where
            ("category LIKE '%#{category}%' AND title LIKE '%#{search}%'")
            .order(created_at: :desc)
    render json: @houses
  end

  def own        #GET properties owned by user /houses/own  ||  /houses/own.json
    @houses = House.where(user_id: authenticate_user!).order(created_at: :desc)
    render json: @houses
  end

  def show       #GET a specific /houses/1 || /houses/1.json
    if @house
      render json: @house
    else
      render json: nil, status: :unauthorized
    end
  end

  def create     #POST /houses || /houses.json
    @house = House.new(house_params)     #NEW house object
    @house.update_attribute(:user_id, authenticate_user!.id)     #additional attribute
    @house.save

    render json: @house
  end

  def update     #PATCH /houses/1 || /houses/1.json
    if @house
      @house.update(house_params)
      render json: @house
    else
      render json: nil, status: :unauthorized
    end
  end

  private
    def set_house
      @house = House.find_by(user_id: authenticate_user!, id: params[:id])
    end

    def house_params
      params.require(:house).permit(:title, :description, :address, :image,
      :category, :price, :bathroom, :bedroom, :car)
    end
end