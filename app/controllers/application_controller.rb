class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session


private
  def hash_id 
    Hashids.new(Rails.configuration.hashid.salt, Rails.configuration.hashid.minimum_length, Rails.configuration.hashid.authorized)
  end

  def encode_to_hash_id(id)
    hash_id.encode(id)
  end
  helper_method :encode_to_hash_id
end
