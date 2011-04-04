# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sorcery}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Noam Ben Ari"]
  s.date = %q{2011-04-04}
  s.description = %q{Provides common authentication needs such as signing in/out, activating by email and resetting password.}
  s.email = %q{nbenari@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/generators/sorcery_migration/sorcery_migration_generator.rb",
    "lib/generators/sorcery_migration/templates/activity_logging.rb",
    "lib/generators/sorcery_migration/templates/brute_force_protection.rb",
    "lib/generators/sorcery_migration/templates/core.rb",
    "lib/generators/sorcery_migration/templates/oauth.rb",
    "lib/generators/sorcery_migration/templates/remember_me.rb",
    "lib/generators/sorcery_migration/templates/reset_password.rb",
    "lib/generators/sorcery_migration/templates/user_activation.rb",
    "lib/sorcery.rb",
    "lib/sorcery/controller.rb",
    "lib/sorcery/controller/adapters/sinatra.rb",
    "lib/sorcery/controller/submodules/activity_logging.rb",
    "lib/sorcery/controller/submodules/brute_force_protection.rb",
    "lib/sorcery/controller/submodules/http_basic_auth.rb",
    "lib/sorcery/controller/submodules/oauth.rb",
    "lib/sorcery/controller/submodules/oauth/oauth1.rb",
    "lib/sorcery/controller/submodules/oauth/oauth2.rb",
    "lib/sorcery/controller/submodules/oauth/providers/facebook.rb",
    "lib/sorcery/controller/submodules/oauth/providers/twitter.rb",
    "lib/sorcery/controller/submodules/remember_me.rb",
    "lib/sorcery/controller/submodules/session_timeout.rb",
    "lib/sorcery/crypto_providers/aes256.rb",
    "lib/sorcery/crypto_providers/bcrypt.rb",
    "lib/sorcery/crypto_providers/md5.rb",
    "lib/sorcery/crypto_providers/sha1.rb",
    "lib/sorcery/crypto_providers/sha256.rb",
    "lib/sorcery/crypto_providers/sha512.rb",
    "lib/sorcery/engine.rb",
    "lib/sorcery/model.rb",
    "lib/sorcery/model/submodules/activity_logging.rb",
    "lib/sorcery/model/submodules/brute_force_protection.rb",
    "lib/sorcery/model/submodules/oauth.rb",
    "lib/sorcery/model/submodules/remember_me.rb",
    "lib/sorcery/model/submodules/reset_password.rb",
    "lib/sorcery/model/submodules/user_activation.rb",
    "lib/sorcery/model/temporary_token.rb",
    "lib/sorcery/sinatra.rb",
    "lib/sorcery/test_helpers.rb",
    "lib/sorcery/test_helpers/rails.rb",
    "lib/sorcery/test_helpers/sinatra.rb",
    "sorcery.gemspec",
    "spec/Gemfile",
    "spec/Gemfile.lock",
    "spec/Rakefile",
    "spec/rails3/.rspec",
    "spec/rails3/app_root/.gitignore",
    "spec/rails3/app_root/.rspec",
    "spec/rails3/app_root/Gemfile",
    "spec/rails3/app_root/Gemfile.lock",
    "spec/rails3/app_root/README",
    "spec/rails3/app_root/Rakefile",
    "spec/rails3/app_root/Rakefile.unused",
    "spec/rails3/app_root/app/controllers/application_controller.rb",
    "spec/rails3/app_root/app/helpers/application_helper.rb",
    "spec/rails3/app_root/app/mailers/sorcery_mailer.rb",
    "spec/rails3/app_root/app/models/authentication.rb",
    "spec/rails3/app_root/app/models/user.rb",
    "spec/rails3/app_root/app/views/layouts/application.html.erb",
    "spec/rails3/app_root/app/views/sorcery_mailer/activation_email.html.erb",
    "spec/rails3/app_root/app/views/sorcery_mailer/activation_email.text.erb",
    "spec/rails3/app_root/app/views/sorcery_mailer/activation_success_email.html.erb",
    "spec/rails3/app_root/app/views/sorcery_mailer/activation_success_email.text.erb",
    "spec/rails3/app_root/app/views/sorcery_mailer/reset_password_email.html.erb",
    "spec/rails3/app_root/app/views/sorcery_mailer/reset_password_email.text.erb",
    "spec/rails3/app_root/config.ru",
    "spec/rails3/app_root/config/application.rb",
    "spec/rails3/app_root/config/boot.rb",
    "spec/rails3/app_root/config/database.yml",
    "spec/rails3/app_root/config/environment.rb",
    "spec/rails3/app_root/config/environments/development.rb",
    "spec/rails3/app_root/config/environments/in_memory.rb",
    "spec/rails3/app_root/config/environments/production.rb",
    "spec/rails3/app_root/config/environments/test.rb",
    "spec/rails3/app_root/config/initializers/backtrace_silencers.rb",
    "spec/rails3/app_root/config/initializers/inflections.rb",
    "spec/rails3/app_root/config/initializers/mime_types.rb",
    "spec/rails3/app_root/config/initializers/secret_token.rb",
    "spec/rails3/app_root/config/initializers/session_store.rb",
    "spec/rails3/app_root/config/locales/en.yml",
    "spec/rails3/app_root/config/routes.rb",
    "spec/rails3/app_root/db/migrate/activation/20101224223622_add_activation_to_users.rb",
    "spec/rails3/app_root/db/migrate/activity_logging/20101224223624_add_activity_logging_to_users.rb",
    "spec/rails3/app_root/db/migrate/brute_force_protection/20101224223626_add_brute_force_protection_to_users.rb",
    "spec/rails3/app_root/db/migrate/core/20101224223620_create_users.rb",
    "spec/rails3/app_root/db/migrate/oauth/20101224223628_create_authentications.rb",
    "spec/rails3/app_root/db/migrate/remember_me/20101224223623_add_remember_me_token_to_users.rb",
    "spec/rails3/app_root/db/migrate/reset_password/20101224223622_add_reset_password_to_users.rb",
    "spec/rails3/app_root/db/schema.rb",
    "spec/rails3/app_root/db/seeds.rb",
    "spec/rails3/app_root/lib/tasks/.gitkeep",
    "spec/rails3/app_root/public/404.html",
    "spec/rails3/app_root/public/422.html",
    "spec/rails3/app_root/public/500.html",
    "spec/rails3/app_root/public/favicon.ico",
    "spec/rails3/app_root/public/images/rails.png",
    "spec/rails3/app_root/public/index.html",
    "spec/rails3/app_root/public/javascripts/application.js",
    "spec/rails3/app_root/public/javascripts/controls.js",
    "spec/rails3/app_root/public/javascripts/dragdrop.js",
    "spec/rails3/app_root/public/javascripts/effects.js",
    "spec/rails3/app_root/public/javascripts/prototype.js",
    "spec/rails3/app_root/public/javascripts/rails.js",
    "spec/rails3/app_root/public/robots.txt",
    "spec/rails3/app_root/public/stylesheets/.gitkeep",
    "spec/rails3/app_root/script/rails",
    "spec/rails3/app_root/spec/controller_activity_logging_spec.rb",
    "spec/rails3/app_root/spec/controller_brute_force_protection_spec.rb",
    "spec/rails3/app_root/spec/controller_http_basic_auth_spec.rb",
    "spec/rails3/app_root/spec/controller_oauth2_spec.rb",
    "spec/rails3/app_root/spec/controller_oauth_spec.rb",
    "spec/rails3/app_root/spec/controller_remember_me_spec.rb",
    "spec/rails3/app_root/spec/controller_session_timeout_spec.rb",
    "spec/rails3/app_root/spec/controller_spec.rb",
    "spec/rails3/app_root/spec/spec_helper.orig.rb",
    "spec/rails3/app_root/spec/spec_helper.rb",
    "spec/rails3/app_root/spec/user_activation_spec.rb",
    "spec/rails3/app_root/spec/user_activity_logging_spec.rb",
    "spec/rails3/app_root/spec/user_brute_force_protection_spec.rb",
    "spec/rails3/app_root/spec/user_oauth_spec.rb",
    "spec/rails3/app_root/spec/user_remember_me_spec.rb",
    "spec/rails3/app_root/spec/user_reset_password_spec.rb",
    "spec/rails3/app_root/spec/user_spec.rb",
    "spec/rails3/app_root/vendor/plugins/.gitkeep",
    "spec/sinatra/Gemfile",
    "spec/sinatra/Gemfile.lock",
    "spec/sinatra/Rakefile",
    "spec/sinatra/authentication.rb",
    "spec/sinatra/db/migrate/activation/20101224223622_add_activation_to_users.rb",
    "spec/sinatra/db/migrate/activity_logging/20101224223624_add_activity_logging_to_users.rb",
    "spec/sinatra/db/migrate/brute_force_protection/20101224223626_add_brute_force_protection_to_users.rb",
    "spec/sinatra/db/migrate/core/20101224223620_create_users.rb",
    "spec/sinatra/db/migrate/oauth/20101224223628_create_authentications.rb",
    "spec/sinatra/db/migrate/remember_me/20101224223623_add_remember_me_token_to_users.rb",
    "spec/sinatra/db/migrate/reset_password/20101224223622_add_reset_password_to_users.rb",
    "spec/sinatra/filters.rb",
    "spec/sinatra/myapp.rb",
    "spec/sinatra/sorcery_mailer.rb",
    "spec/sinatra/spec/controller_activity_logging_spec.rb",
    "spec/sinatra/spec/controller_brute_force_protection_spec.rb",
    "spec/sinatra/spec/controller_http_basic_auth_spec.rb",
    "spec/sinatra/spec/controller_oauth2_spec.rb",
    "spec/sinatra/spec/controller_oauth_spec.rb",
    "spec/sinatra/spec/controller_remember_me_spec.rb",
    "spec/sinatra/spec/controller_session_timeout_spec.rb",
    "spec/sinatra/spec/controller_spec.rb",
    "spec/sinatra/spec/spec.opts",
    "spec/sinatra/spec/spec_helper.rb",
    "spec/sinatra/spec/user_activation_spec.rb",
    "spec/sinatra/spec/user_activity_logging_spec.rb",
    "spec/sinatra/spec/user_brute_force_protection_spec.rb",
    "spec/sinatra/spec/user_oauth_spec.rb",
    "spec/sinatra/spec/user_remember_me_spec.rb",
    "spec/sinatra/spec/user_reset_password_spec.rb",
    "spec/sinatra/spec/user_spec.rb",
    "spec/sinatra/user.rb",
    "spec/sinatra/views/test_login.erb",
    "spec/sorcery_crypto_providers_spec.rb",
    "spec/spec_helper.rb",
    "spec/untitled folder"
  ]
  s.homepage = %q{http://github.com/NoamB/sorcery}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Magical authentication for Rails 3 applications}
  s.test_files = [
    "spec/rails3/app_root/app/controllers/application_controller.rb",
    "spec/rails3/app_root/app/helpers/application_helper.rb",
    "spec/rails3/app_root/app/mailers/sorcery_mailer.rb",
    "spec/rails3/app_root/app/models/authentication.rb",
    "spec/rails3/app_root/app/models/user.rb",
    "spec/rails3/app_root/config/application.rb",
    "spec/rails3/app_root/config/boot.rb",
    "spec/rails3/app_root/config/environment.rb",
    "spec/rails3/app_root/config/environments/development.rb",
    "spec/rails3/app_root/config/environments/in_memory.rb",
    "spec/rails3/app_root/config/environments/production.rb",
    "spec/rails3/app_root/config/environments/test.rb",
    "spec/rails3/app_root/config/initializers/backtrace_silencers.rb",
    "spec/rails3/app_root/config/initializers/inflections.rb",
    "spec/rails3/app_root/config/initializers/mime_types.rb",
    "spec/rails3/app_root/config/initializers/secret_token.rb",
    "spec/rails3/app_root/config/initializers/session_store.rb",
    "spec/rails3/app_root/config/routes.rb",
    "spec/rails3/app_root/db/migrate/activation/20101224223622_add_activation_to_users.rb",
    "spec/rails3/app_root/db/migrate/activity_logging/20101224223624_add_activity_logging_to_users.rb",
    "spec/rails3/app_root/db/migrate/brute_force_protection/20101224223626_add_brute_force_protection_to_users.rb",
    "spec/rails3/app_root/db/migrate/core/20101224223620_create_users.rb",
    "spec/rails3/app_root/db/migrate/oauth/20101224223628_create_authentications.rb",
    "spec/rails3/app_root/db/migrate/remember_me/20101224223623_add_remember_me_token_to_users.rb",
    "spec/rails3/app_root/db/migrate/reset_password/20101224223622_add_reset_password_to_users.rb",
    "spec/rails3/app_root/db/schema.rb",
    "spec/rails3/app_root/db/seeds.rb",
    "spec/rails3/app_root/spec/controller_activity_logging_spec.rb",
    "spec/rails3/app_root/spec/controller_brute_force_protection_spec.rb",
    "spec/rails3/app_root/spec/controller_http_basic_auth_spec.rb",
    "spec/rails3/app_root/spec/controller_oauth2_spec.rb",
    "spec/rails3/app_root/spec/controller_oauth_spec.rb",
    "spec/rails3/app_root/spec/controller_remember_me_spec.rb",
    "spec/rails3/app_root/spec/controller_session_timeout_spec.rb",
    "spec/rails3/app_root/spec/controller_spec.rb",
    "spec/rails3/app_root/spec/spec_helper.orig.rb",
    "spec/rails3/app_root/spec/spec_helper.rb",
    "spec/rails3/app_root/spec/user_activation_spec.rb",
    "spec/rails3/app_root/spec/user_activity_logging_spec.rb",
    "spec/rails3/app_root/spec/user_brute_force_protection_spec.rb",
    "spec/rails3/app_root/spec/user_oauth_spec.rb",
    "spec/rails3/app_root/spec/user_remember_me_spec.rb",
    "spec/rails3/app_root/spec/user_reset_password_spec.rb",
    "spec/rails3/app_root/spec/user_spec.rb",
    "spec/sinatra/authentication.rb",
    "spec/sinatra/db/migrate/activation/20101224223622_add_activation_to_users.rb",
    "spec/sinatra/db/migrate/activity_logging/20101224223624_add_activity_logging_to_users.rb",
    "spec/sinatra/db/migrate/brute_force_protection/20101224223626_add_brute_force_protection_to_users.rb",
    "spec/sinatra/db/migrate/core/20101224223620_create_users.rb",
    "spec/sinatra/db/migrate/oauth/20101224223628_create_authentications.rb",
    "spec/sinatra/db/migrate/remember_me/20101224223623_add_remember_me_token_to_users.rb",
    "spec/sinatra/db/migrate/reset_password/20101224223622_add_reset_password_to_users.rb",
    "spec/sinatra/filters.rb",
    "spec/sinatra/myapp.rb",
    "spec/sinatra/sorcery_mailer.rb",
    "spec/sinatra/spec/controller_activity_logging_spec.rb",
    "spec/sinatra/spec/controller_brute_force_protection_spec.rb",
    "spec/sinatra/spec/controller_http_basic_auth_spec.rb",
    "spec/sinatra/spec/controller_oauth2_spec.rb",
    "spec/sinatra/spec/controller_oauth_spec.rb",
    "spec/sinatra/spec/controller_remember_me_spec.rb",
    "spec/sinatra/spec/controller_session_timeout_spec.rb",
    "spec/sinatra/spec/controller_spec.rb",
    "spec/sinatra/spec/spec_helper.rb",
    "spec/sinatra/spec/user_activation_spec.rb",
    "spec/sinatra/spec/user_activity_logging_spec.rb",
    "spec/sinatra/spec/user_brute_force_protection_spec.rb",
    "spec/sinatra/spec/user_oauth_spec.rb",
    "spec/sinatra/spec/user_remember_me_spec.rb",
    "spec/sinatra/spec/user_reset_password_spec.rb",
    "spec/sinatra/spec/user_spec.rb",
    "spec/sinatra/user.rb",
    "spec/sorcery_crypto_providers_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<json>, [">= 1.5.1"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.4"])
      s.add_runtime_dependency(%q<oauth2>, [">= 0.1.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<simplecov>, [">= 0.3.8"])
      s.add_runtime_dependency(%q<bcrypt-ruby>, ["~> 2.1.4"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.4"])
      s.add_runtime_dependency(%q<oauth2>, [">= 0.1.1"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<json>, [">= 1.5.1"])
      s.add_dependency(%q<oauth>, [">= 0.4.4"])
      s.add_dependency(%q<oauth2>, [">= 0.1.1"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<simplecov>, [">= 0.3.8"])
      s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1.4"])
      s.add_dependency(%q<oauth>, [">= 0.4.4"])
      s.add_dependency(%q<oauth2>, [">= 0.1.1"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<json>, [">= 1.5.1"])
    s.add_dependency(%q<oauth>, [">= 0.4.4"])
    s.add_dependency(%q<oauth2>, [">= 0.1.1"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<simplecov>, [">= 0.3.8"])
    s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1.4"])
    s.add_dependency(%q<oauth>, [">= 0.4.4"])
    s.add_dependency(%q<oauth2>, [">= 0.1.1"])
  end
end

