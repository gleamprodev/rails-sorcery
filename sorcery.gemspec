# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sorcery"
  s.version = "0.7.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Noam Ben Ari"]
  s.date = "2012-01-03"
  s.description = "Provides common authentication needs such as signing in/out, activating by email and resetting password."
  s.email = "nbenari@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.rdoc .document .rspec LICENSE.txt Rakefile VERSION)

  s.homepage = "http://github.com/NoamB/sorcery"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Magical authentication for Rails 3 applications"

  s.add_runtime_dependency(%q<oauth>, ["~> 0.4.4"])
  s.add_runtime_dependency(%q<oauth2>, ["~> 0.5.1"])

  s.add_development_dependency(%q<bcrypt-ruby>, ["~> 3.0.0"])
  s.add_development_dependency(%q<rails>, [">= 3.0.0"])
  s.add_development_dependency(%q<json>, [">= 1.5.1"])
  s.add_development_dependency(%q<rspec>, ["~> 2.5.0"])
  s.add_development_dependency(%q<rspec-rails>, ["~> 2.5.0"])
  s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
  s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
  s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
  s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
  s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
  s.add_development_dependency(%q<simplecov>, [">= 0.3.8"])
  s.add_development_dependency(%q<capybara>, [">= 1.1.2"])
  s.add_development_dependency(%q<mongoid>, ["~> 2.4.4"])
  s.add_development_dependency(%q<timecop>, [">= 0"])
end

