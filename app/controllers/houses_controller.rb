class HouseController < ApplicationController
  #before any actions authenticate user
  before_action :authenticate_user!
  before_action :set_house, only: [:show, :update]

  def index      #GET /houses || /houses.json
  end

  def own        #GET properties owned by user /houses/own  ||  /houses/own.json
  end

  def show       #GET a specific /houses/1 || /houses/1.json
  end

  def create     #POST /houses || /houses.json
  end

  def update     #PATCH /houses/1 || /houses/1.json
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