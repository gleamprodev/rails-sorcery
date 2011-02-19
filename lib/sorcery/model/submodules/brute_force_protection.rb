module Sorcery
  module Model
    module Submodules
      # This module helps protect user accounts by locking them down after too many failed attemps to login were detected.
      # This is the model part of the submodule which provides configuration options and methods for locking and unlocking the user.
      module BruteForceProtection
        def self.included(base)
          base.sorcery_config.class_eval do
            attr_accessor :failed_logins_count_attribute_name,        # failed logins attribute name.
                          :lock_expires_at_attribute_name,            # this field indicates whether user is banned and when it will be active again.
                          :consecutive_login_retries_amount_limit,    # how many failed logins allowed.
                          :login_lock_time_period                     # how long the user should be banned. in seconds. 0 for permanent.
          end
          
          base.sorcery_config.instance_eval do
            @defaults.merge!(:@failed_logins_count_attribute_name              => :failed_logins_count,
                             :@lock_expires_at_attribute_name                  => :lock_expires_at,
                             :@consecutive_login_retries_amount_limit          => 50,
                             :@login_lock_time_period                          => 3600)
            reset!
          end
          
          base.class_eval do

          end
          
          base.sorcery_config.before_authenticate << :prevent_locked_user_login
          base.extend(ClassMethods)
          base.send(:include, InstanceMethods)
        end
        
        module ClassMethods
          protected
          
        end
        
        module InstanceMethods
          # Called by the controller to increment the failed logins counter.
          # Calls 'lock!' if login retries limit was reached.
          def register_failed_login!
            config = sorcery_config
            self.increment(config.failed_logins_count_attribute_name)
            save!
            self.lock! if self.send(config.failed_logins_count_attribute_name) >= config.consecutive_login_retries_amount_limit
          end
          
          protected

          def lock!
            config = sorcery_config
            self.update_attributes!(config.lock_expires_at_attribute_name => Time.now.utc + config.login_lock_time_period)
          end

          def unlock!
            config = sorcery_config
            self.update_attributes!(config.lock_expires_at_attribute_name => nil, 
                                    config.failed_logins_count_attribute_name => 0)
          end
          
          def unlocked?
            config = sorcery_config
            self.send(config.lock_expires_at_attribute_name).nil?
          end
          
          # Prevents a locked user from logging in, and unlocks users that expired their lock time.
          # Runs as a hook before authenticate.
          def prevent_locked_user_login
            config = sorcery_config
            if !self.unlocked? && config.login_lock_time_period != 0
              self.unlock! if self.send(config.lock_expires_at_attribute_name) <= Time.now.utc
            end
            unlocked?
          end
        end
      end
    end
  end
end