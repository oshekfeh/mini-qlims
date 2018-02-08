class TestTypesController < ApplicationController
  before_action :set_test_type, only: [:show, :update]

  # GET /todos
  def index
    @test_types = TestType.all
    json_repsonse_include(@test_types, :sample_types, :ok)
  end

  # POST /todos
  def create
    permitted_params = test_type_params
    #pop out test type from the params
    @sample_types = permitted_params.delete(:sample_types)

    #create sample type object
    @test_type = TestType.new(permitted_params)

    #get test types IDs as array and look for them in the database
    if @sample_types
      @sample_types = @sample_types.map{|t| t[:id]}
      @sample_types = SampleType.find(@sample_types)

      #assign test types
      @test_type.sample_types = @sample_types
    end

    #Save in the database in one transaction!!
    @test_type.save!
    json_repsonse_include(@test_type, :sample_types, :created)
  end

  # GET /todos/:id
  def show
    json_repsonse_include(@test_type, :sample_types, :ok)
  end

  # PUT /todos/:id
  def update
    permitted_params = test_type_params

    @sample_types = permitted_params.delete(:sample_types)

    if @sample_types
      @sample_types = @sample_types.map{|t| t[:id]}
      @sample_types = SampleType.find(@sample_types)
      permitted_params[:sample_types] = @sample_types
    end
    @test_type.update(permitted_params)
    head :no_content
  end

  private

  def test_type_params
    # whitelist params
    params.permit(:name, sample_types: [:id, :name])
  end

  def set_test_type
    @test_type = TestType.find(params[:id])
  end
end
