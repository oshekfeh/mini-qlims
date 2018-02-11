class SampleRequestsController < ApplicationController
  before_action :set_sample_request, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @sample_requests = SampleRequest.all
    json_repsonse_include(@sample_requests, :samples, :ok)
  end

  # POST /todos
  def create
    @sample_request = SampleRequest.create!(request_params)
    json_response(@sample_request, :created)
  end

  # GET /todos/:id
  def show
    json_repsonse_include(@sample_request, :samples, :ok)
  end

  # PUT /todos/:id
  def update
    @sample_request.update(request_params)
    head :no_content
  end

  # DELETE /todos/:id
  # def destroy
  #   @request.destroy
  #   head :no_content
  # end

  private

  def request_params
    # whitelist params
    params.permit(:code, :status)
  end

  def set_sample_request
    @sample_request = SampleRequest.find(params[:id])
  end
end
