class Admin::AdminUsers::RegistrationsController < Devise::RegistrationsController
  before_action :set_page_title, :authenticate_admin_admin_user!
  helper_method :end_session_path, :current_cie_user, :session_root_path, :edit_cie_user_path
  include Admin::ApplicationHelper
  layout "admin/dashboard_layout"
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
     redirect_to admin_root_path
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
     super
  end

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

  def controller?(*controller)
      controller.include?(params[:controller])
  end

  def action?(*action)
      action.include?(params[:action])
  end

  private

  def set_page_title
      @page_title = "Admin Management"
  end

  def current_cie_user
      current_admin_admin_user
  end

  def end_session_path
      destroy_admin_admin_user_session_path
  end

  def session_root_path
      admin_root_path
  end

  def edit_cie_user_path
      edit_admin_admin_user_registration_path
  end

  protected

  def after_update_path_for(resource)
      edit_admin_admin_user_registration_path(resource)
  end

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