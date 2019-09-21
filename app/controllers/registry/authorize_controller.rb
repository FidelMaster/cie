class Registry::AuthorizeController < Registry::ApplicationController
	load_and_authorize_resource
	
	rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to registry_root_path, notice: exception.message }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end

    private

    def current_ability
      @current_ability ||= Admin::RegistryAbility.new(current_cie_user)
    end
end