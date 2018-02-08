module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_repsonse_include(object, assoc_childs = {}, status)
    render json: object, include: assoc_childs, status: status
  end
end
