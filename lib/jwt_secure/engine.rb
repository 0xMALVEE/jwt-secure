module JwtSecure
  class Engine < ::Rails::Engine
    paths.add "lib", eager_load: true
    isolate_namespace JwtSecure
  end
end
