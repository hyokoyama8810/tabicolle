# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: :destroy

  def check_guest
    # if resource.email == 'guest@example.com'
    #   redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    # end
    redirect_to root_path, alert: 'ゲストユーザーは削除できません。' if resource.email == 'guest@example.com'
  end

  def destroy; end
end
