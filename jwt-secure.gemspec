# Name of the gem
Gem::Specification.new do |spec|
  spec.name          = "jwt-secure"
  spec.version       = "0.1.6"
  spec.authors       = ["M Alvee"]
  spec.email         = ["m.alvee8141@gmail.com"]
  spec.summary       = "Secure JWT authentication for Ruby on Rails that uses http only cookies."
  spec.homepage      = "https://github.com/0xMALVEE/jwt-secure"
  spec.license       = "MIT"
  spec.files         = Dir["lib/**/*.rb"]
  # Required Ruby version and Rails version
  spec.add_dependency 'rails', '>= 0'
  spec.add_dependency "jwt", ">= 0"
end
