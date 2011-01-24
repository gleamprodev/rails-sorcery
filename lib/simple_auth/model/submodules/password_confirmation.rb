module SimpleAuth
  module Model
    module Submodules
      # This submodule adds the ability to verify that the user filled the password twice,
      # and that both times were the same string.
      module PasswordConfirmation
        def self.included(base)
          # changes to the SimpleAuth::Model::Config class
          base.simple_auth_config.class_eval do
            attr_accessor :password_confirmation_attribute_name
          end
          
          # changes to simple_auth_config class instance variable
          base.simple_auth_config.instance_eval do
            @defaults.merge!(:@password_confirmation_attribute_name => :password_confirmation)
            reset!
          end
          
          # changes to the actual model
          base.class_eval do
            attr_accessor @simple_auth_config.password_confirmation_attribute_name
            validate :password_confirmed
          end
          
          base.send(:include, InstanceMethods)
        end
        
        module InstanceMethods
          protected

          def password_confirmed
            config = simple_auth_config
            if self.send(config.password_attribute_name) && self.send(config.password_attribute_name) != self.send(config.password_confirmation_attribute_name)
              self.errors.add(:base,"password and password_confirmation do not match!")
            end
          end
        end
      end
    end
  end
end