class Api::TestController < ApiController 
  def some
    render json: {some: "shit"}
  end

end