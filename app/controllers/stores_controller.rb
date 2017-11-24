class StoresController < ApplicationController
  FILTER_TYPES = { "eq": "=", "like": "LIKE", "gt": ">", "lt": "<" }

  before_action :set_store, only: [:show, :update, :destroy]

  def index
    @stores = Store.all

    store_params.each do |attribute, filter|
      filter_type = filter.split(":")[0]
      filter_value = filter.split(":")[1]

      @stores = @stores.where(attribute + " " + FILTER_TYPES[filter_type.to_sym] + " ?", filter_value)
    end

    # optimized
    #
    # query_string = store_params.to_hash.map { |attribute, filter|
    #   filter_type = filter.split(":")[0];
    #   attribute + " " + FILTER_TYPES[filter_type.to_sym] + " ?"
    # }.join(" AND ")

    # @stores = @stores.where(query_string, store_params.to_hash.map { |attribute, filter| filter.split(":")[1] })    

    json_response(@stores)
  end

  def show
    json_response(@store)
  end

  def create
    @store = Store.create!(store_params)

    json_response(@store, :created)
  end

  def update
    @store.update(store_params)

    json_response(@store)
  end

  def destroy
    @store.destroy

    head :no_content
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.permit(:title, :city, :street)
  end
end
