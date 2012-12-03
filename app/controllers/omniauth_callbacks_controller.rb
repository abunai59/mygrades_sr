class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def ldap
    #We only find ourselves here if the authentication to LDAP was successful.
    ldap_return = request.env["omniauth.auth"]["extra"]["raw_info"]
    username = ldap_return.uid[0].to_s

    if @user = User.find_by_username(username)
      sign_in_and_redirect @user
    else
      @user = User.create(:username => username,)
      sign_in_and_redirect @user
    end
  end
end
