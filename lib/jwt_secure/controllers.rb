require "jwt"


class JsonWebToken
  def self.encode(payload, key)
    JWT.encode(payload,key)
  end

  def self.decode(token, key)
    puts key
    JWT.decode(token,key).first
  end

end

module JwtSecure
  class ApiJwtController < ApplicationController
    before_action(:authenticate_jwtsecure)

  
    def authenticate_jwtsecure()
      begin 
        payload = JsonWebToken.decode(get_auth_token, @jwtsecure_secret)
        if payload.present?
          @current_user = User.find(payload["user_id"])
        else
          render json: {errors: ["Invalid Token, user not found!"]}, status: :unauthorized
        end
      rescue
        render json: {errors: ["token not found!"]}, status: :unauthorized
      end
    end
  
    def get_auth_token()
      @auth_token ||= cookies.encrypted[@jwtsecure_cookiename]
    end
  end

  class AuthController < ApplicationController
    def login
       # find user
      user = @jwtsecure_usermodel.find_by(@jwtsecure_findby)

      if user && user.authenticate(@jwtsecure_password)
        # password is correct -> proced to login
        # set toke inside httpOnly Cookie
        jwt_token = JsonWebToken.encode({user_id: user.id},@jwtsecure_secret)
        cookies.encrypted[@jwtsecure_cookiename] = {
          value: jwt_token,
          http_only: true,
          same_site: :strict
        }
        render json: {message: "Successfull login!", success: true, user: user}, status: :ok
      else
        # password incorrect -> failed login
        render json: {errors: ["Invalid email or password"], success: false}, status: :unauthorized
      end
    end

    def logout
      cookies.encrypted[@jwtsecure_cookiename] = {
        value: "",
        http_only: true,
        same_site: :strict
      }
      render json: {message: "logged out, cookie removed", success: true}, status: :ok
    end
  end
end