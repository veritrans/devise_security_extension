module DeviseSecurityExtension::Patches
  module PasswordsControllerSecurityQuestion
    extend ActiveSupport::Concern
    included do
      define_method :create do
        # only find via email, not login
        self.resource = resource_class.find_or_initialize_with_error_by(:email, params[resource_name][:email], :not_found)
        session[:temp_resource] = {:class => self.resource.class.to_s, :id => self.resource.id}
        if self.resource
          render action: 'security_question'
        else
          flash[:alert] = t('devise.email_not_found') if is_navigational_format?
          respond_with({}, :location => new_password_path(resource_name))
        end
      end

      define_method :security_question do
        self.resource = session[:temp_resource][:class].constantize.find(session[:temp_resource][:id].to_i)
        if self.resource.security_question_answer == params[resource_name][:security_question_answer]
          resource = resource_class.send_reset_password_instructions(params[resource_name].merge(:email => self.resource.email ))
          if successfully_sent?(resource)
            redirect_to new_session_path(resource_name)
          else
            respond_with(resource)
          end
        else
          flash[:alert] = t('devise.invalid_security_question') if is_navigational_format?
        end
      end
    end
  end
end
