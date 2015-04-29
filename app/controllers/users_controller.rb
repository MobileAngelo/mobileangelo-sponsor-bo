class UsersController < ApplicationController
  http_basic_authenticate_with :name => "mobileangelo", :password => "mobileangelorockssomuch!", only: [:show]
  before_action :clean_input, only: [:create]

  def create
    @user = User.find_or_initialize_by mobile: params[:user][:mobile],
                                        email: params[:user][:email]
  
    @user.assign_attributes(user_params)

    if @user.save
      render status: :ok
    else 
      render status: :bad_request
    end
  end

  def show
    @user = User.find_by id: User.decode_hash_id(params[:id])

    if @user
      render status: :ok
    else 
      render status: :not_found
    end
  end
  
private 

  def clean_input
    params[:user][:mobile] = PhonyRails.normalize_number params[:user][:mobile], default_country_code: 'FR'
    params[:user][:email]  = params[:user][:email].delete(' ').downcase
  end

  def user_params 
    params.require(:user).permit :mobile, 
                                 :email, 
                                 :firstname, 
                                 :lastname
  end

end
