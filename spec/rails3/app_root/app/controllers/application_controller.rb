class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :timeout_session, :only => [:test_should_be_logged_in] if defined?(:timeout_session)
  before_filter :authenticate, :only => [:test_logout, :test_should_be_logged_in]
  
  def index
    render :text => ""
  end
  
  def test_login
    @user = login(params[:username], params[:password])
    render :text => ""
  end
  
  def test_logout
    logout
    render :text => ""
  end
  
  def test_logout_with_remember
    remember_me!
    logout
    render :text => ""
  end
  
  def test_login_with_remember
    @user = login(params[:username], params[:password])
    remember_me!
    
    render :text => ""
  end
  
  def test_login_with_remember_in_login
    @user = login(params[:username], params[:password], params[:remember])
    
    render :text => ""
  end
  
  def test_login_from_cookie
    @user = logged_in_user
    render :text => ""
  end
  
  def test_not_authenticated_action
    render :text => "test_not_authenticated_action"
  end
  
  def test_should_be_logged_in
    render :text => ""
  end
  
  protected
  
  def not_authenticated
    redirect_to root_path
  end

end
