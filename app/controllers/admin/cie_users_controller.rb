class Admin::CieUsersController < Admin::ApplicationController
  before_action :set_admin_cie_user, only: [:show, :edit, :update, :destroy]
  layout "admin/dashboard_layout"

  # GET /academico/cie_users
  # GET /academico/cie_users.json
  def index
    @admin_cie_users = Registry::CieUser.all
  end

  # GET /academico/cie_users/1
  # PATCH/PUT /academico/cie_users/1
  # GET /academico/cie_users/1.json
  def show
  end

  # GET /academico/cie_users/new
  def new
    @admin_cie_user = Registry::CieUser.new
  end

  # GET /academico/cie_users/1/edit
  def edit
    @selected_role = @admin_cie_user.admin_cie_roles.map{|b| b.id.to_s}
  end

  # POST /academico/cie_users
  # POST /academico/cie_users.json
  def create
    @admin_cie_user = Registry::CieUser.new(admin_cie_user_params.except :admin_cie_role_ids)
    if admin_cie_user_params[:admin_cie_role_ids]
        @admin_cie_user.admin_cie_roles.delete_all
        admin_cie_user_params[:admin_cie_role_ids].each do |role|
          @admin_cie_user.admin_cie_roles << Admin::CieRole.find(role)
        end
    end
    @selected_role = @admin_cie_user.admin_cie_roles.map{|b| b.id}
    respond_to do |format|
      if @admin_cie_user.save
        format.html { redirect_to admin_cie_user_path(@admin_cie_user.id), notice: 'Usuario de registro fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @admin_cie_user }
      else
        format.html { render :new }
        format.json { render json: @admin_cie_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /academico/cie_users/1.json
  def update
    respond_to do |format|      
      if admin_cie_user_params[:admin_cie_role_ids]
        @admin_cie_user.admin_cie_roles.delete_all
        admin_cie_user_params[:admin_cie_role_ids].each do |role|
          @admin_cie_user.admin_cie_roles << Admin::CieRole.find(role)
        end

        @selected_role = @admin_cie_user.admin_cie_roles.map{|b| b.id.to_s}
        if (admin_cie_user_params[:password].blank? &&
           @admin_cie_user.update_without_password(admin_cie_user_params.except :admin_cie_role_ids)) ||
           @admin_cie_user.update(admin_cie_user_params.except :admin_cie_role_ids)
          format.html { redirect_to admin_cie_user_path(@admin_cie_user.id), notice: 'Usuario de registro fue actualizado exitosamente.' }
          format.json { render :show, status: :ok, location: @admin_cie_user }
        else
          format.html { render :edit }
          format.json { render json: @admin_cie_user.errors, status: :unprocessable_entity }
        end
      else
        @admin_cie_user.errors.add(:admin_cie_roles, "Seleccione el rol del usuario")
        format.html { render :edit }
      end
      
    end
  end

  # DELETE /academico/cie_users/1
  # DELETE /academico/cie_users/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to admin_cie_users_url, notice: 'Usuario de registro fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:admin_cie_user_ids].each do |id|
      @cie_resource = Registry::CieUser.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to admin_cie_users_url, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_cie_user
      @admin_cie_user = Registry::CieUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_cie_user_params
      params.require(:registry_cie_user).permit(:name, :email, :password, :password_confirmation, :is_evaluator,
        {:admin_cie_role_ids => []})
    end
end