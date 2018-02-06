class TestTypesController < ApplicationController
  before_action :set_test_type, only: [:show, :update]

  # GET /todos
  def index
    @test_types = TestType.all
    json_response(@test_types)
  end

  # POST /todos
  def create
    @test_type = TestType.create!(test_type_params)
    json_response(@test_type, :created)
  end

  # GET /todos/:id
  def show
    json_response(@test_type)
  end

  # PUT /todos/:id
  def update
    @test_type.update(test_type_params)
    head :no_content
  end

  private

  def test_type_params
    # whitelist params
    params.permit(:name)
  end

  def set_test_type
    @test_type = TestType.find(params[:id])
  end
end
