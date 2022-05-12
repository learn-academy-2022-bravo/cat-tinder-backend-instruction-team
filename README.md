# Setup Installs:
  $ rails new cat-tinder-backend -d postgresql -T
  $ cd cat-tinder-backend
  $ rails db:create
  $ bundle add rspec-rails
  $ rails generate rspec:install

  $ rails generate resource Cat name:string age:integer enjoys:text image:text
  $ rails db:migrate

   - Checked rspec is running: $ rspec spec

# Seeds
- Added seed content to db/seeds
  $ rails db:seed
- Use rails console to see data in database by running Cat.all


# CORS
- Enabled controller to accept requests from outside applications:
```ruby
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
end
```
- Added cors gem: gem 'rack-cors', :require => 'rack/cors'
- Added cors.rb to config/initializers with below code:
```ruby
# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # <- change this to allow requests from any domain while in development.

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```