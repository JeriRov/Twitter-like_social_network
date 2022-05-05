require 'net/http'
require 'uri'
require 'json'
class Auth::SessionsController < Devise::SessionsController
  layout false
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end
  # POST /resource/sign_in
  def create
    super
    data = params[:user]
    uri = URI('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDSmfYSrr4spJFGn4hOkk3GDcUnDeoZH5g')
    res = Net::HTTP.post_form(uri, email: data["email"], password: data["password"])
    data_js = JSON.parse(res.body)
    if res.is_a?(Net::HTTPSuccess) and current_user
      @errors = ""
      session[:user_id] = data_js['localId']

    end
  end


  # DELETE /resource/sign_out
  def destroy
    session.clear
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
