require 'net/http'
require 'uri'
require 'json'
class Auth::RegistrationsController < Devise::RegistrationsController
  layout false, only: :create
  def new
    super
  end

  def create
    super
    data = params[:user]
    uri = URI('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDSmfYSrr4spJFGn4hOkk3GDcUnDeoZH5g')
    res = Net::HTTP.post_form(uri, email: data["email"], password: data["password"])
    data_js = JSON.parse(res.body)
    if res.is_a?(Net::HTTPSuccess) and current_user
      session[:user_id] = data_js['localId']
    end
  end


  # GET /resource/edit
  #def edit
  # super
  #end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
