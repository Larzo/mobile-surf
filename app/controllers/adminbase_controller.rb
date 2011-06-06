class AdminbaseController < ApplicationController

before_filter :check_login, :except => ['login','authorize']

def login
end  

def authorize
pw = params[:password]
if (pw == 'bigfish12')
  session[:admin_logged_in] = true
end

end

def check_login
  logged_in = false
  if session[:admin_logged_in] 
      logged_in = true
  end
  if !logged_in
    redirect_to :action => 'login', :controller => 'adminbase'
  end
end



end