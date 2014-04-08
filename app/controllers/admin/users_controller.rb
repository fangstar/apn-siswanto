class Admin::UsersController < ApplicationController
  before_action :set_user, :only => [:edit, :show, :destroy, :update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params.delete_if{|k,v| v.blank?})
        format.html { redirect_to admin_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    # authorize! :destroy, @user, :message => 'Not authorized as an administrator.'

    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_path }
    end
  end

  private 
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :first_name, :last_name, :email, :roles => [])
  end
end
