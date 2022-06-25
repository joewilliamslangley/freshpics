class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:freshpics_handle, :email, :password)}

               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:freshpics_handle, :email, :password)}
          end

          def default_url_options
            { host: ENV["DOMAIN"] || "localhost:3000" }
          end
end
