class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  http_basic_authenticate_with :name => "mobileangelo", :password => "mobileangelorockssomuch!", :if => :admin_controller?

  def admin_controller?
    self.class < ActiveAdmin::BaseController
  end
end
