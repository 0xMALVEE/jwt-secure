class ApiController < JwtSecure::ApiJwtController

  def authenticate_jwtsecure
    @jwtsecure_cookiename = :mysite_token
    @jwtsecure_secret = "some_key_string_secret"
    super
  end
end