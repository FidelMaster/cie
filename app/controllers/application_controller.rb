class ApplicationController < ActionController::Base
	include Pundit


  	before_action :set_cie_resource, only: [:destroy]
	skip_before_action :set_cie_resource, if: :devise_controller?
	before_action :configure_account_update_params, if: :devise_controller?
	protect_from_forgery with: :exception
	skip_before_action :verify_authenticity_token, if: :devise_controller?

	rescue_from ActiveRecord::InvalidForeignKey, CustomExceptions::RecordAssociationException do
		respond_to do |format|
			format.html { redirect_to({controller: controller_name, action: "index"}, notice: @cie_resource.errors.messages[:base].first)}
			format.json { head :no_content }
		end
	end

	rescue_from CustomExceptions::SpecialException do
		respond_to do |format|
			if	@registry_employee.present?
				format.html { render :new, notice: @registry_employee.errors.messages[:base].first}
			else
				format.html { render :edit, notice: @cie_resource.errors.messages[:base].first}
			end
			format.json { head :no_content }
		end
	end

	def configure_account_update_params
		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
	end

	private

	def set_cie_resource
		@cie_resource = controller_path.classify.constantize.find(params[:id])
	end
end
