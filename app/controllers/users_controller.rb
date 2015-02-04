class UsersController < ApplicationController
  before_action :clean_input, only: :create

  def index
  end

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
