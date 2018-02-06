class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :update]

  # GET /todos
  def index
    @units = Unit.all
    json_response(@units)
  end

  # POST /todos
  def create
    @unit = Unit.create!(unit_params)
    json_response(@unit, :created)
  end

  # GET /todos/:id
  def show
    json_response(@unit)
  end

  # PUT /todos/:id
  def update
    @unit.update(unit_params)
    head :no_content
  end

  private

  def unit_params
    # whitelist params
    params.permit(:name)
  end

  def set_unit
    @unit = Unit.find(params[:id])
  end
end
