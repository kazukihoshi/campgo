# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create] #退会の論理削除

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end






  def user_state #退会処理の論理削除
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
      @user = User.find_by(email: params[:user][:email])
      ## アカウントを取得できなかった場合、このメソッドを終了する
      return if !@user
      ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @user.valid_password?(params[:user][:password]) && @user.is_delete == false
        flash[:danger] = '退会済みです。申し訳ございませんが、再度新規登録をお願いいたします。'
      #byebug
        redirect_to new_user_session_path
      end
      ## 【処理内容3】
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


  # def new_guest
  #   user = User.guest
  #   sign_in user   # ユーザーをログインさせる
  #   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  # end

end

