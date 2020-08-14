class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #CSRF(サイトに攻撃用のコードを仕込み、アクセスしたユーザーに対して意図しない操作を行わせる攻撃)対策
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
    # 新規登録､更新をする際に登録するパラメーターを増やす
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
end
