class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_current_user
    
    def set_current_user
      @current_user = User.find(session[:user_id]) if session[:user_id]
    end

    def set_user
      @user = User.find(params[:id])
    end
   
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    def correct_user
      unless current_user?(@user)
         redirect_to(root_url)
         flash[:danger] = "ユーザが違います。"
      end
    end
    
    def admin_user
      if logged_in?
        redirect_to root_url unless current_user.admin?
      end
    end
    
    def login_user
      if logged_in?
        redirect_to user_url(current_user)
        flash[:danger] = "すでにログインしています。"
      end
    end
    
    def login_and_not_adimn_user
      if logged_in? 
        unless current_user.admin?
          redirect_to user_url(current_user)
          flash[:danger] = "すでにログインしています。"
        end 
      end
    end

end
