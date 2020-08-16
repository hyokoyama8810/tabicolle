class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #CSRF(サイトに攻撃用のコードを仕込み、アクセスしたユーザーに対して意図しない操作を行わせる攻撃)対策
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後のリダイレクト先を指定
  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  protected
    # 新規登録､更新をする際に登録するパラメーターを増やす
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
end
