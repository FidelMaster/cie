class Admin::ApplicationController < ApplicationController
	protect_from_forgery with: :exception
	before_action :set_page_title, :authenticate_admin_admin_user!
	helper_method :end_session_path, :current_cie_user, :session_root_path, :edit_cie_user_path
	include Admin::ApplicationHelper

	def controller?(*controller)
		controller.include?(params[:controller])
	end

	def action?(*action)
		action.include?(params[:action])
	end

	private

	def set_page_title
		@page_title = "Settings"
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
end