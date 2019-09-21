class Registry::EmployeesController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_employee, only: [:show, :edit, :update, :destroy]
  before_action :set_cie_resource, only: [:update]

  # GET /registry/employees
  # GET /registry/employees.json
  def index
    @registry_employees = filtering_params(params).paginate(:page => params[:page])
  end

  def filtering_params(params)
    if params[:filter].present?
      Registry::Employee.filter(params[:filter].slice(:employee, :employee_position, :active))
    else
      Registry::Employee.all
    end
  end

  # GET /registry/employees/1
  # GET /registry/employees/1.json
  def show
  end

  # GET /registry/employees/new
  def new
    @registry_employee = Registry::Employee.new
  end

  # GET /registry/employees/1/edit
  def edit
  end

  # POST /registry/employees
  # POST /registry/employees.json
  def create
    @registry_employee = Registry::Employee.new(registry_employee_params)
    
    respond_to do |format|
      if @registry_employee.save
        format.html { redirect_to @registry_employee, notice: 'Empleado fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_employee }
      else
        format.html { render :new }
        format.json { render json: @registry_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/employees/1
  # PATCH/PUT /registry/employees/1.json
  def update
    respond_to do |format|

      if @registry_employee.update(registry_employee_params)
        format.html { redirect_to @registry_employee, notice: 'Empleado fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_employee }
      else
        format.html { render :edit }
        format.json { render json: @registry_employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/employees/1
  # DELETE /registry/employees/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_employees_url, notice: 'Empleado fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_employee_ids].each do |id|
      @cie_resource = Registry::Employee.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_employees_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  def load_boss
    boss = Registry::Employee.get_coordinadores
      .where(:registry_therapy_group => params[:therapy_group_id])
   
    boss = boss.where("id != ?", params[:self_id]) if params[:self_id].present?
    
    @boss = boss if boss.present?
    
    @selected_boss = params[:boss_id]

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_employee
      @registry_employee = Registry::Employee.find(params[:id])
    end
    def set_cie_resource
      @cie_resource = Registry::Employee.find(params[:id])
    end
    def resource_params
      registry_employee_params
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_employee_params
      params.require(:registry_employee).permit(:first_name, :last_name, :email, :birth_date, :registry_employee_position_id, :start_date, :active, :avatar, :boss_id, :registry_therapy_group_id)
    end
end
