require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe User, "when app has plugin loaded" do
  it "should respond to the plugin activation class method" do
    ActiveRecord::Base.should respond_to(:activate_simple_auth!)
    User.should respond_to(:activate_simple_auth!)
  end
end

# ----------------- PLUGIN CONFIGURATION -----------------------
describe User, "loaded plugin configuration" do
  after(:each) do
    User.simple_auth_config.reset!
  end
  
  it "should enable submodules in parameters" do
    plugin_model_configure([:password_confirmation])
    User.simple_auth_config.should respond_to(:password_confirmation_attribute_name)
    plugin_model_configure()
  end
  
  it "should enable configuration option 'username_attribute_name'" do
    plugin_set_model_config_property(:username_attribute_name, :email)
    User.simple_auth_config.username_attribute_name.should equal(:email)    
  end
  
  it "should enable configuration option 'password_attribute_name'" do
    plugin_set_model_config_property(:password_attribute_name, :mypassword)
    User.simple_auth_config.password_attribute_name.should equal(:mypassword)
  end
  
  describe "with PasswordConfirmation" do
    before(:all) do
      plugin_model_configure([:password_confirmation])
    end
    
    it "should enable configuration option 'password_confirmation_attribute_name'" do
      plugin_set_model_config_property(:password_confirmation_attribute_name, :mypassword_conf)
      User.simple_auth_config.password_confirmation_attribute_name.should equal(:mypassword_conf)
    end
  end
  
  describe "with PasswordEncryption" do
    before(:all) do
      plugin_model_configure([:password_encryption])
    end
    
    it "should enable configuration option 'crypted_password_attribute_name'" do
      plugin_set_model_config_property(:crypted_password_attribute_name, :password)
      User.simple_auth_config.crypted_password_attribute_name.should equal(:password)
    end

    it "should enable configuration option 'encryption_algorithm'" do
      plugin_set_model_config_property(:encryption_algorithm, :none)
      User.simple_auth_config.encryption_algorithm.should equal(:none)
    end

    it "should enable configuration option 'encryption_key'" do
      plugin_set_model_config_property(:encryption_key, 'asdadas424234242')
      User.simple_auth_config.encryption_key.should == 'asdadas424234242'
    end

    it "should enable configuration option 'custom_encryption_provider'" do
      plugin_set_model_config_property(:encryption_algorithm, :custom)
      plugin_set_model_config_property(:custom_encryption_provider, Array)
      User.simple_auth_config.custom_encryption_provider.should equal(Array)
    end
  end

  it "should enable two classes to have different configurations" do
    plugin_set_model_config_property(:username_attribute_name, :email)
    TestUser.simple_auth_config.username_attribute_name.should equal(:username)
  end
  
end

# ----------------- PLUGIN ACTIVATED -----------------------
describe User, "when activated with simple_auth" do
  before(:each) do
    User.delete_all
  end
  
  it "should respond to class method authenticate" do
    ActiveRecord::Base.should_not respond_to(:authenticate)
    User.should respond_to(:authenticate)
  end
  
  it "authenticate should return true if credentials are good" do
    create_new_user
    User.authenticate(@user.send(User.simple_auth_config.username_attribute_name), 'secret').should be_true
  end
  
  it "authenticate should return false if credentials are bad" do
    create_new_user
    User.authenticate(@user.send(User.simple_auth_config.username_attribute_name), 'wrong!').should be_false
  end
  
  describe "with PasswordEncryption" do
    before(:all) do
      plugin_model_configure([:password_encryption])
    end
  
    it "should respond to the class method encrypt" do
      User.should respond_to(:encrypt)
    end
  end
end

# ----------------- REGISTRATION -----------------------
describe User, "registration" do
  before(:all) do
    plugin_model_configure
  end
  
  before(:each) do
    User.delete_all
  end
  
  describe "with PasswordEncryption" do
    before(:all) do
      plugin_model_configure([:password_encryption])
    end
  
    it "should encrypt password when a new user is saved" do
      create_new_user
      @user.send(User.simple_auth_config.crypted_password_attribute_name).should == User.encrypt('secret')
    end
  
    it "should not encrypt the password twice when a user is updated" do
      create_new_user
      @user.email = "blup@bla.com"
      @user.save!
      @user.send(User.simple_auth_config.crypted_password_attribute_name).should == User.encrypt('secret')
    end
  
    it "should replace the crypted_password in case a new password is set" do
      create_new_user
      @user.password = 'new_secret'
      @user.save!
      @user.send(User.simple_auth_config.crypted_password_attribute_name).should == User.encrypt('new_secret')
    end
    
    describe "with password_confirmation module" do
      it "should replace the crypted_password in case a new password is set" do
        plugin_model_configure([:password_confirmation, :password_encryption])
        create_new_user
        @user.password = 'new_secret'
        @user.password_confirmation = 'new_secret'
        @user.save!
        @user.send(User.simple_auth_config.crypted_password_attribute_name).should == User.encrypt('new_secret')
      end
    end
  end
end

# ----------------- PASSWORD CONFIRMATION -----------------------
describe User, "password confirmation" do
  before(:each) do
    User.delete_all
  end
  
  after(:each) do
    User.simple_auth_config.reset!
  end
  
  it "should not register a user with mismatching password fields" do
    plugin_model_configure([:password_confirmation])
    @user = User.new(:username => 'gizmo', :email => "bla@bla.com", :password => 'secret', :password_confirmation => 'secrer')
    @user.valid?.should == false
    @user.save.should == false
    expect{@user.save!}.to raise_error(ActiveRecord::RecordInvalid)
  end
end

# ----------------- PASSWORD ENCRYPTION -----------------------
describe User, "special encryption cases" do
  before(:all) do
    plugin_model_configure([:password_encryption])
    @text = "Some Text!"
  end
  
  before(:each) do
    User.delete_all
  end
  
  after(:each) do
    User.simple_auth_config.reset!
  end
  
  it "should work with no password encryption" do
    plugin_set_model_config_property(:encryption_algorithm, :none)
    create_new_user
    User.authenticate(@user.send(User.simple_auth_config.username_attribute_name), 'secret').should be_true
  end
  
  it "should work with custom password encryption" do
    class MyCrypto
      def self.encrypt(*tokens)
        tokens.flatten.join('').gsub(/e/,'A')
      end
    end
    plugin_set_model_config_property(:encryption_algorithm, :custom)
    plugin_set_model_config_property(:custom_encryption_provider, MyCrypto)
    create_new_user
    User.authenticate(@user.send(User.simple_auth_config.username_attribute_name), 'secret').should be_true
  end
  
  it "if encryption algo is aes256, it should set key to crypto provider" do
    plugin_set_model_config_property(:encryption_algorithm, :aes256)
    plugin_set_model_config_property(:encryption_key, nil)
    expect{User.encrypt(@text)}.to raise_error(ArgumentError)
    plugin_set_model_config_property(:encryption_key, "asd234dfs423fddsmndsflktsdf32343")
    expect{User.encrypt(@text)}.to_not raise_error(ArgumentError)
  end
  
  it "if encryption algo is md5 it should work" do
    plugin_set_model_config_property(:encryption_algorithm, :md5)
    User.encrypt(@text).should == SimpleAuth::CryptoProviders::MD5.encrypt(@text)
  end
  
  it "if encryption algo is sha1 it should work" do
    plugin_set_model_config_property(:encryption_algorithm, :sha1)
    User.encrypt(@text).should == SimpleAuth::CryptoProviders::SHA1.encrypt(@text)
  end
  
  it "if encryption algo is sha256 it should work" do
    plugin_set_model_config_property(:encryption_algorithm, :sha256)
    User.encrypt(@text).should == SimpleAuth::CryptoProviders::SHA256.encrypt(@text)
  end
  
  it "if encryption algo is sha512 it should work" do
    plugin_set_model_config_property(:encryption_algorithm, :sha512)
    User.encrypt(@text).should == SimpleAuth::CryptoProviders::SHA512.encrypt(@text)
  end
  
end