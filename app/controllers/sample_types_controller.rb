class SampleTypesController < ApplicationController
  before_action :set_sample_type, only: [:show, :update]

  # GET /todos
  def index
    @sample_types = SampleType.all
    json_repsonse_include(@sample_types, :test_types, :ok)
  end

  # POST /todos
  def create
    permitted_params = sample_type_params
    #pop out test type from the params
    @test_types = permitted_params.delete(:test_types)

    #create sample type object
    @sample_type = SampleType.new(permitted_params)

    #get test types IDs as array and look for them in the database
    if @test_types
      @test_types = @test_types.map{|t| t[:id]}
      @test_types = TestType.find(@test_types)

      #assign test types
      @sample_type.test_types = @test_types
    end

    #Save in the database in one transaction!!
    @sample_type.save!
    json_repsonse_include(@sample_type, :test_types, :created)
  end

  # GET /todos/:id
  def show
    json_repsonse_include(@sample_type, :test_types, :ok)
  end

  # PUT /todos/:id
  def update
    permitted_params = sample_type_params

    @test_types = permitted_params.delete(:test_types)

    if @test_types
      @test_types = @test_types.map{|t| t[:id]}
      @test_types = TestType.find(@test_types)
      permitted_params[:test_types] = @test_types
    end
    @sample_type.update(permitted_params)
    head :no_content
  end

  private

  def sample_type_params
    # whitelist params
    params.permit(:name, test_types: [:id, :name])
  end

  def set_sample_type
    @sample_type = SampleType.find(params[:id])
  end
end
