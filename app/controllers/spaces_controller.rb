class SpacesController < ApplicationController
  before_action :set_store
  before_action :set_space, only: [:show, :update, :destroy, :price]

  def index
    @spaces = Space.all

    json_response(@spaces)
  end

  def show
    json_response(@space)
  end

  def create
    @space = Space.create!(space_params)

    json_response(@space, :created)
  end

  def update
    @space.update(space_params)

    json_response(@space)
  end

  def destroy
    @space.destroy

    head :no_content
  end

  def price
    json_response({ price: @space.price(Date.parse(params[:start_date]),
                                        Date.parse(params[:end_date]))})
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.permit(:store_id, :title, :size,
                  :price_per_day, :price_per_week, :price_per_month)
  end
end
