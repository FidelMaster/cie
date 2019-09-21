class Admin::CieRolesController < Admin::ApplicationController
  before_action :set_admin_cie_role, only: [:show, :edit, :update, :destroy]
  layout "admin/dashboard_layout"

  # GET /admin/cie_roles
  # GET /admin/cie_roles.json
  def index
    @admin_cie_roles = Admin::CieRole.all
  end

  # GET /admin/cie_roles/1
  # GET /admin/cie_roles/1.json
  def show
  end

  # GET /admin/cie_roles/new
  def new
    @admin_cie_role = Admin::CieRole.new
    @resources = Admin::Resource.where('module' => 'Registry')
    @actions = Admin::Action.all
    @index = 0
    @academico_permissions = Admin::Permission.joins(:admin_resources).where('admin_resources.module' => 'Registry')
  end

  # GET /admin/cie_roles/1/edit
  def edit
    @resources = Admin::Resource.where('module' => 'Registry')
    @actions = Admin::Action.all
    @index = 0
    @academico_permissions = Admin::Permission.joins(:admin_resources).where('admin_resources.module' => 'Registry')
  end

  # POST /admin/cie_roles
  # POST /admin/cie_roles.json
  def create
    @admin_cie_role = Admin::CieRole.new(admin_cie_role_params.except :admin_cie_role_permissions_attributes)

    if admin_cie_role_params[:admin_cie_role_permissions_attributes]
      @admin_cie_role.admin_cie_role_permissions.delete_all
      admin_cie_role_params[:admin_cie_role_permissions_attributes].each do |role_permission|
        record = admin_cie_role_params[:admin_cie_role_permissions_attributes][role_permission]
        if record[:permission_validator]
          @admin_cie_role.admin_cie_role_permissions << Admin::CieRolePermission.new(record.to_unsafe_h)
        end
      end
    end


    respond_to do |format|
      if @admin_cie_role.save
        format.html { redirect_to @admin_cie_role, notice: 'Role de usuario de registro fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @admin_cie_role }
      else
        format.html { render :new }
        format.json { render json: @admin_cie_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/cie_roles/1
  # PATCH/PUT /admin/cie_roles/1.json
  def update
    if admin_cie_role_params[:admin_cie_role_permissions_attributes]
      @admin_cie_role.admin_cie_role_permissions.delete_all
      admin_cie_role_params[:admin_cie_role_permissions_attributes].each do |role_permission|
        record = admin_cie_role_params[:admin_cie_role_permissions_attributes][role_permission]
        if record[:permission_validator]
          @admin_cie_role.admin_cie_role_permissions << Admin::CieRolePermission.new(record.to_unsafe_h)
        end
      end
    end
    respond_to do |format|
      if @admin_cie_role.update(admin_cie_role_params.except :admin_cie_role_permissions_attributes)
        format.html { redirect_to @admin_cie_role, notice: 'Role de usuario de registro fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @admin_cie_role }
      else
        format.html { render :edit }
        format.json { render json: @admin_cie_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/cie_roles/1
  # DELETE /admin/cie_roles/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to admin_cie_roles_url, notice: 'Role de usuario de registro fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:admin_cie_role_ids].each do |id|
      @cie_resource = Admin::CieRole.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to admin_cie_roles_url, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_cie_role
      @admin_cie_role = Admin::CieRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_cie_role_params
      params.require(:admin_cie_role).permit(:name, :admin_cie_role_permissions_attributes=> [:permission_validator, :admin_resource_id, :admin_action_id, :_destroy, :id])
    end
end
