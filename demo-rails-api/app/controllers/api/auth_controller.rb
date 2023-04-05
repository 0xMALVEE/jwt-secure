class Api::AuthController < JwtSecure::AuthController
  skip_before_action :verify_authenticity_token
  
  def login
    @jwtsecure_usermodel = User
    @jwtsecure_findby = { username: params[:username] }
    @jwtsecure_password = params[:password]
    @jwtsecure_cookiename = :mysite_token
    @jwtsecure_secret = "some_key_string_secret"
    super
  end

  def logout
    @jwtsecure_cookiename = :mysite_token
    super
  end

  
end