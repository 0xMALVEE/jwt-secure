class ApiController < JwtSecure::ApiJwtController
  skip_before_action :verify_authenticity_token

  def authenticate_jwtsecure
    @jwtsecure_cookiename = :mysite_token
    @jwtsecure_secret = "some_key_string_secret"
    super
  end
end