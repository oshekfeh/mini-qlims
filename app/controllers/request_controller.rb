class RequestController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @requests = Request.all
    json_response(@requests)
  end

  # POST /todos
  def create
    @request = Request.create!(request_params)
    json_response(@request, :created)
  end

  # GET /todos/:id
  def show
    json_response(@request)
  end

  # PUT /todos/:id
  def update
    @request.update(request_params)
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

  def set_request
    @request = Request.find(params[:id])
  end
end
