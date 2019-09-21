class Registry::ApplicationController < ApplicationController
	protect_from_forgery with: :exception
	before_action :set_page_title, :authenticate_registry_cie_user!
	helper_method :end_session_path, :current_cie_user, :session_root_path, :edit_cie_user_path
	include Registry::ApplicationHelper

	def controller?(*controller)
		controller.include?(params[:controller])
	end

	def action?(*action)
		action.include?(params[:action])
	end

	private

	def set_page_title
		@page_title = "Registry"
	end

	def current_cie_user
		current_registry_cie_user
	end
	
	def end_session_path
		destroy_registry_cie_user_session_path
	end

	def session_root_path
		registry_root_path
	end
	
	def edit_cie_user_path
		edit_registry_cie_user_registration_path
	end
end