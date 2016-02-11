# Use this module to configure the sabisu available options

if Rails.env.development?

  SabisuRails.setup do |config|

    # Base uri for posting the 
    config.base_api_uri = 'api.locket_server.dev'

    # Ignored attributes for building the forms
    # config.ignored_attributes = %w{ created_at updated_at id }
    
    # HTTP methods
    # config.http_methods = %w{ GET POST PUT DELETE PATCH }
    
    # Headers to include on each request
    #
    # You can configure the api headers fairly easy by just adding the correct headers
    # config.api_headers = { "Accept" => "application/json,application/vnd.application.v1" }
    #
    config.api_headers = { "Accept" => "application/vnd.locket_server.v1" }

    # Layout configuration
    # config.layout = "sabisu"

    # Resources on the api
    config.resources = [ :users, :image_assets, :lockets ]

    # Application name
    # mattr_accessor :app_name
    # @@app_name = Rails.application.class.parent_name

    # Authentication
    # mattr_accessor :authentication_username
    # @@authentication_username = "admin"

    # mattr_accessor :authentication_password
    # @@authentication_password = "sekret"

  end
end
