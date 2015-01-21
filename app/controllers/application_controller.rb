class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
   rescue_from Pundit::NotAuthorizedError do |exception|
     Rails.logger.info ">>>>> exception: #{exception.inspect}"
     #policy_name = exception.policy.class.to_s.underscore
     #flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
     
     redirect_to root_url, alert: "You are not authorized to perform this action."
   end
  protected
 
   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :name
   end
     
     def upgrade
       self.role = "premium"
     end
     
end
