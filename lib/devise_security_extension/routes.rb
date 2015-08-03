module ActionDispatch::Routing
  class Mapper

    protected

    # route for handle expired passwords
    def devise_password_expired(mapping, controllers)
      resource :password_expired, :only => [:show, :update], :path => mapping.path_names[:password_expired], :controller => controllers[:password_expired]
    end
	
	def devise_password(mapping, controllers) #:nodoc:
	resource :password, :only => [:new, :create, :edit, :update],
	  :path => mapping.path_names[:password], :controller => controllers[:passwords] do
	  	put 'security_question', :action => :security_question, :as => "security_question"
	  end
	end

    # route for handle paranoid verification
    def devise_verification_code(mapping, controllers)
      resource :paranoid_verification_code, :only => [:show, :update], :path => mapping.path_names[:verification_code], :controller => controllers[:paranoid_verification_code]
    end
  end
end

