shared_examples_for "rails_3_core_model" do
  describe User, "loaded plugin configuration" do
    after(:each) do
      User.sorcery_config.reset!
    end

    it "enables configuration option 'username_attribute_names'" do
      sorcery_model_property_set(:username_attribute_names, :email)

      expect(User.sorcery_config.username_attribute_names).to eq [:email]
    end

    it "enables configuration option 'password_attribute_name'" do
      sorcery_model_property_set(:password_attribute_name, :mypassword)

      expect(User.sorcery_config.password_attribute_name).to eq :mypassword
    end

    it "enables configuration option 'email_attribute_name'" do
      sorcery_model_property_set(:email_attribute_name, :my_email)

      expect(User.sorcery_config.email_attribute_name).to eq :my_email
    end

    it "enables configuration option 'crypted_password_attribute_name'" do
      sorcery_model_property_set(:crypted_password_attribute_name, :password)

      expect(User.sorcery_config.crypted_password_attribute_name).to eq :password
    end

    it "enables configuration option 'salt_attribute_name'" do
      sorcery_model_property_set(:salt_attribute_name, :my_salt)

      expect(User.sorcery_config.salt_attribute_name).to eq :my_salt
    end

    it "enables configuration option 'encryption_algorithm'" do
      sorcery_model_property_set(:encryption_algorithm, :none)

      expect(User.sorcery_config.encryption_algorithm).to eq :none
    end

    it "enables configuration option 'encryption_key'" do
      sorcery_model_property_set(:encryption_key, 'asdadas424234242')

      expect(User.sorcery_config.encryption_key).to eq 'asdadas424234242'
    end

    it "enables configuration option 'custom_encryption_provider'" do
      sorcery_model_property_set(:encryption_algorithm, :custom)
      sorcery_model_property_set(:custom_encryption_provider, Array)

      expect(User.sorcery_config.custom_encryption_provider).to eq Array
    end

    it "enables configuration option 'salt_join_token'" do
      salt_join_token = "--%%*&-"
      sorcery_model_property_set(:salt_join_token, salt_join_token)

      expect(User.sorcery_config.salt_join_token).to eq salt_join_token
    end

    it "enables configuration option 'stretches'" do
      stretches = 15
      sorcery_model_property_set(:stretches, stretches)

      expect(User.sorcery_config.stretches).to eq stretches
    end
  end

  # ----------------- PLUGIN ACTIVATED -----------------------
  describe User, "when activated with sorcery" do
    before(:all) do
      sorcery_reload!
    end

    before(:each) do
      User.delete_all
    end

    it "does not add authenticate method to base class", active_record: true do
      expect(ActiveRecord::Base).not_to respond_to(:authenticate) if defined?(ActiveRecord)
    end

    it "responds to class method authenticate" do
      expect(User).to respond_to :authenticate
    end

    it "authenticate returns true if credentials are good" do
      create_new_user
      username = @user.send(User.sorcery_config.username_attribute_names.first)

      expect(User.authenticate username, 'secret').to be_truthy
    end

    it "authenticate returns nil if credentials are bad" do
      create_new_user
      username = @user.send(User.sorcery_config.username_attribute_names.first)

      expect(User.authenticate username, 'wrong!').to be nil
    end

    context "with empty credentials" do
      before do
        sorcery_model_property_set(:downcase_username_before_authenticating, true)
      end

      after do
        sorcery_reload!
      end

      it "don't downcase empty credentials" do
        expect(User.authenticate(nil, 'wrong!')).to be_falsy
      end
    end

    specify { expect(User).to respond_to(:encrypt) }

    it "subclass inherits config if defined so" do
      sorcery_reload!([],{:subclasses_inherit_config => true})
      class Admin < User; end

      expect(Admin.sorcery_config).not_to be_nil
      expect(Admin.sorcery_config).to eq User.sorcery_config
    end

    it "subclass does not inherit config if not defined so" do
      sorcery_reload!([],{:subclasses_inherit_config => false})
      class Admin2 < User; end

      expect(Admin2.sorcery_config).to be_nil
    end
  end

  # ----------------- REGISTRATION -----------------------
  describe User, "registration" do

    before(:all) do
      sorcery_reload!()
    end

    before(:each) do
      User.delete_all
    end

    it "by default, encryption_provider is not nil" do
      expect(User.sorcery_config.encryption_provider).not_to be_nil
    end

    it "encrypts password when a new user is saved" do
      create_new_user
      crypted_password = @user.send User.sorcery_config.crypted_password_attribute_name

      expect(User.sorcery_config.encryption_provider.matches? crypted_password, 'secret', @user.salt).to be true
    end

    it "clears the virtual password field if the encryption process worked" do
      create_new_user

      expect(@user.password).to be_nil
    end

    it "does not clear the virtual password field if save failed due to validity" do
      create_new_user

      User.class_eval do
        validates_format_of :email, :with => /\A(.)+@(.)+\Z/, :if => Proc.new {|r| r.email}, :message => "is invalid"
      end

      @user.password = 'blupush'
      @user.email = 'asd'
      @user.save

      expect(@user.password).not_to be_nil
    end

    it "does not clear the virtual password field if save failed due to exception" do
      create_new_user
      @user.password = '4blupush'
      @user.username = nil
      User.class_eval do
        validates_presence_of :username
      end
      begin
        if defined?(DataMapper) && @user.class.ancestors.include?(DataMapper::Resource)
          @user.save
        else
          @user.save! # triggers validation exception since username field is required.
        end
      rescue
      end

      expect(@user.password).not_to be_nil
    end

    it "does not encrypt the password twice when a user is updated" do
      create_new_user
      @user.email = "blup@bla.com"
      if defined?(DataMapper) && @user.class.ancestors.include?(DataMapper::Resource)
        @user.save
      else
        @user.save!
      end
      crypted_password = @user.send(User.sorcery_config.crypted_password_attribute_name)

      expect(User.sorcery_config.encryption_provider.matches? crypted_password, 'secret', @user.salt).to be true
    end

    it "replaces the crypted_password in case a new password is set" do
      create_new_user
      @user.password = 'new_secret'
      if defined?(DataMapper) && @user.class.ancestors.include?(DataMapper::Resource)
        @user.save
      else
        @user.save!
      end
      crypted_password = @user.send(User.sorcery_config.crypted_password_attribute_name)

      expect(User.sorcery_config.encryption_provider.matches? crypted_password, 'secret', @user.salt).to be false
    end

    describe "when user has password_confirmation_defined" do
      before(:all) do
        User.class_eval { attr_accessor :password_confirmation }
        if defined?(DataMapper)
          DataMapper.finalize
        end
      end

      after(:all) do
        User.send(:remove_method, :password_confirmation)
        User.send(:remove_method, :password_confirmation=)
      end

      it "clears the virtual password field if the encryption process worked" do
        create_new_user(username: "u", password: "secret", password_confirmation: "secret", email: "email@example.com")

        expect(@user.password_confirmation).to be_nil
      end

      it "does not clear the virtual password field if save failed due to validity" do
        User.class_eval do
          validates_format_of :email, :with => /\A(.)+@(.)+\Z/
        end
        build_new_user(username: "u", password: "secret", password_confirmation: "secret", email: "asd")
        @user.save

        expect(@user.password_confirmation).not_to be_nil
      end
    end

  end

  # ----------------- PASSWORD ENCRYPTION -----------------------
  describe User, "special encryption cases" do
    before(:all) do
      sorcery_reload!()
      @text = "Some Text!"
    end

    before(:each) do
      User.delete_all
    end

    after(:each) do
      User.sorcery_config.reset!
    end

    it "works with no password encryption" do
      sorcery_model_property_set(:encryption_algorithm, :none)
      create_new_user
      username = @user.send(User.sorcery_config.username_attribute_names.first)

      expect(User.authenticate username, 'secret').to be_truthy
    end

    it "works with custom password encryption" do
      class MyCrypto
        def self.encrypt(*tokens)
          tokens.flatten.join('').gsub(/e/,'A')
        end

        def self.matches?(crypted,*tokens)
          crypted == encrypt(*tokens)
        end
      end
      sorcery_model_property_set(:encryption_algorithm, :custom)
      sorcery_model_property_set(:custom_encryption_provider, MyCrypto)
      create_new_user

      username = @user.send(User.sorcery_config.username_attribute_names.first)

      expect(User.authenticate username, 'secret').to be_truthy
    end

    it "if encryption algo is aes256, it sets key to crypto provider" do
      sorcery_model_property_set(:encryption_algorithm, :aes256)
      sorcery_model_property_set(:encryption_key, nil)

      expect { User.encrypt @text }.to raise_error(ArgumentError)

      sorcery_model_property_set(:encryption_key, "asd234dfs423fddsmndsflktsdf32343")

      expect { User.encrypt @text }.not_to raise_error
    end

    it "if encryption algo is aes256, it sets key to crypto provider, even if attributes are set in reverse" do
      sorcery_model_property_set(:encryption_key, nil)
      sorcery_model_property_set(:encryption_algorithm, :none)
      sorcery_model_property_set(:encryption_key, "asd234dfs423fddsmndsflktsdf32343")
      sorcery_model_property_set(:encryption_algorithm, :aes256)

      expect { User.encrypt @text }.not_to raise_error
    end

    it "if encryption algo is md5 it works" do
      sorcery_model_property_set(:encryption_algorithm, :md5)

      expect(User.encrypt @text).to eq Sorcery::CryptoProviders::MD5.encrypt(@text)
    end

    it "if encryption algo is sha1 it works" do
      sorcery_model_property_set(:encryption_algorithm, :sha1)

      expect(User.encrypt @text).to eq Sorcery::CryptoProviders::SHA1.encrypt(@text)
    end

    it "if encryption algo is sha256 it works" do
      sorcery_model_property_set(:encryption_algorithm, :sha256)

      expect(User.encrypt @text).to eq Sorcery::CryptoProviders::SHA256.encrypt(@text)
    end

    it "if encryption algo is sha512 it works" do
      sorcery_model_property_set(:encryption_algorithm, :sha512)

      expect(User.encrypt @text).to eq Sorcery::CryptoProviders::SHA512.encrypt(@text)
    end

    it "salt is random for each user and saved in db" do
      sorcery_model_property_set(:salt_attribute_name, :salt)
      create_new_user

      expect(@user.salt).not_to be_nil
    end

    it "if salt is set uses it to encrypt" do
      sorcery_model_property_set(:salt_attribute_name, :salt)
      sorcery_model_property_set(:encryption_algorithm, :sha512)
      create_new_user

      expect(@user.crypted_password).not_to eq Sorcery::CryptoProviders::SHA512.encrypt('secret')
      expect(@user.crypted_password).to eq Sorcery::CryptoProviders::SHA512.encrypt('secret',@user.salt)
    end

    it "if salt_join_token is set uses it to encrypt" do
      sorcery_model_property_set(:salt_attribute_name, :salt)
      sorcery_model_property_set(:salt_join_token, "-@=>")
      sorcery_model_property_set(:encryption_algorithm, :sha512)
      create_new_user

      expect(@user.crypted_password).not_to eq Sorcery::CryptoProviders::SHA512.encrypt('secret')

      Sorcery::CryptoProviders::SHA512.join_token = ""

      expect(@user.crypted_password).not_to eq Sorcery::CryptoProviders::SHA512.encrypt('secret',@user.salt)

      Sorcery::CryptoProviders::SHA512.join_token = User.sorcery_config.salt_join_token

      expect(@user.crypted_password).to eq Sorcery::CryptoProviders::SHA512.encrypt('secret',@user.salt)
    end

  end

  describe User, "ORM adapter" do
    before(:all) do
      sorcery_reload!()
      User.delete_all
    end

    before(:each) do
      create_new_user
    end

    after(:each) do
      User.delete_all
      User.sorcery_config.reset!
    end

    it "find_by_username works as expected" do
      sorcery_model_property_set(:username_attribute_names, [:username])

      expect(User.find_by_username "gizmo").to eq @user
    end

    it "find_by_username works as expected with multiple username attributes" do
      sorcery_model_property_set(:username_attribute_names, [:username, :email])

      expect(User.find_by_username "gizmo").to eq @user
    end

    it "find_by_email works as expected" do
      expect(User.find_by_email "bla@bla.com").to eq @user
    end
  end
end

shared_examples_for "external_user" do
  before(:each) do
    User.delete_all
  end

  it "responds to 'external?'" do
    create_new_user

    expect(@user).to respond_to(:external?)
  end

  it "external? is false for regular users" do
    create_new_user

    expect(@user.external?).to be false
  end

  it "external? is true for external users" do
    create_new_external_user(:twitter)

    expect(@user.external?).to be true
  end
end
