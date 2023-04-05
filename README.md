
# jwt-secure

JwtSecure is a small gem that helps you use jwt authentication in rails app using http only cookies



## how to use it?
[Check this demo api built using jwt-secure](https://github.com/0xMALVEE/jwt-secure/tree/main/demo-rails-api)

## Step 1:
 Require jwt_scure in config/routes.rb file and add routes for login and logout acording to your needs. note (you don't need to create any namespace you can also define routes without namespace, since most people will be building apis so I created a api namespace in the demo app.)

path: config/routes.rb
```ruby
require 'jwt_secure'

Rails.application.routes.draw do
  namespace :api do
    get "/login", to: "auth#login"
    get "/logout", to: "auth#logout"
    get "/test", to: "test#some" 
  end
end

```

Avobe the route /test is protected by default when we create class `Api::TestController < ApiController` and you have to make sure your ApiController inherit from JwtSecure::ApiJwtController
## Step 2:
Create a base controller like `ApiController < JwtSecure::ApiJwtController` that you will be inheriting in all your api controllers or controllers that needs to be protected / using jwt auth (like only give access if logged in typeof controllers)

path: app/controllers/api_controller.rb
```ruby
class ApiController < JwtSecure::ApiJwtController
  skip_before_action :verify_authenticity_token

  def authenticate_jwtsecure
    @jwtsecure_cookiename = :mysite_token
    @jwtsecure_secret = "some_key_string_secret"
    super
  end
end
```

make sure you have defined the authenticate_jwtsecure method and made two instance variable for cookiename and jwt secret key. Http only cookies will be saved acording to `@jwtsecure_cookiename` variable value

```ruby
@jwtsecure_cookiename = :any_cookie_name 
@jwtsecure_secret = "some_strong_secret_key"
```

## Step 3:
 Create the controller for login and logout route you can name the controller anything you want for this demo app I used the name `auth_controller.rb`

path: app/controller/api/auth_controller.rb
```ruby
class Api::AuthController < JwtSecure::AuthController
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
```
Make sure to profile the user model in `@jwtsecure_usermodel` instance variable. 

`@jwtsecure_findby` should be the query that you want to find the user and check his password. For example if you want to find the user by his email and check password you should put ` @jwtsecure_findby = { email: params[:email] }` or anything that you want acording to your user model. 

`@jwtsecure_password` should be the password that is coming from params from the request at `/api/login` or acording to your routes.

`If user is found and password is correct then you will get a response back with a message and the user info. note(make sure to put same cookiename and jwtsecret for all the instance variable or it won't work)`

## Step 4:
 Your secure jwt auth is now  complete now anything that you want to protect with  jwt auth you can make controller for that and it must inherit from the base controller  that is inheriting from `JwtSecure::ApiJwtController`. In my example I am using `ApiController < JwtSecure::ApiJwtController` so I will use `Api::TestController < ApiController`. 

path: app/controllers/test_controller.rb
```ruby
class Api::TestController < ApiController 
  def some
    puts @current_user
    puts @current_user.username
    render json: {some: "shit", current_user: @current_user.username}
  end

end
```
`@current_user the the user object recieved from the database. you can access user name or email if present or any other information in every controller that is inheriting from the BaseController in this case it's ApiController.`

## Step 5:
 for loging out / clearing the cookie just make a route and point it to your auth controller logout action. Your auth controller should inherit from `JwtSecure::AuthController` and must have `login` and `logout` methods with all required instance variables.

## More info bellow

if you want some routes to not have auth and can be accessed by anytone you can bypass auth check for that controller using `skip_before_action :authenticate_jwtsecure`

Bellow is example of the test route without auth 
path: app/controllers/test_controller.rb
```ruby
class Api::TestController < ApiController 
  skip_before_action :authenticate_jwtsecure
  def some
    puts @current_user #-> will result in error since there is no user cuz route is a open route
    puts @current_user.username #-> will result in error
    render json: {some: "shit"}
  end

end
```



<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/0xMALVEE/jwt-secure/issues).

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>


If you like this project please give a star. 

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>



I would like to thank all the people that contributed in this project .
