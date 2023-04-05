class Api::TestController < ApiController 
  def some
    puts @current_user
    render json: {some: "shit", current_user: @current_user.username}
  end

end