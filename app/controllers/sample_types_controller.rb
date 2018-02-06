class SampleTypesController < ApplicationController
  before_action :set_sample_type, only: [:show, :update]

  # GET /todos
  def index
    @sample_types = SampleType.all
    json_response(@sample_types)
  end

  # POST /todos
  def create
    @sample_type = SampleType.create!(sample_type_params)
    json_response(@sample_type, :created)
  end

  # GET /todos/:id
  def show
    json_response(@sample_type)
  end

  # PUT /todos/:id
  def update
    @sample_type.update(sample_type_params)
    head :no_content
  end

  private

  def sample_type_params
    # whitelist params
    params.permit(:name)
  end

  def set_sample_type
    @sample_type = SampleType.find(params[:id])
  end
end
