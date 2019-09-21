class Registry::EmployeePositionsController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_employee_position, only: [:show, :edit, :update, :destroy]

  # GET /registry/employee_positions
  # GET /registry/employee_positions.json
  def index
    @registry_employee_positions = Registry::EmployeePosition.paginate(:page => params[:page])
  end

  # GET /registry/employee_positions/1
  # GET /registry/employee_positions/1.json
  def show
  end

  # GET /registry/employee_positions/new
  def new
    @registry_employee_position = Registry::EmployeePosition.new
  end

  # GET /registry/employee_positions/1/edit
  def edit
  end

  # POST /registry/employee_positions
  # POST /registry/employee_positions.json
  def create
    @registry_employee_position = Registry::EmployeePosition.new(registry_employee_position_params)

    respond_to do |format|
      if @registry_employee_position.save
        format.html { redirect_to @registry_employee_position, notice: 'Cargo fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_employee_position }
      else
        format.html { render :new }
        format.json { render json: @registry_employee_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/employee_positions/1
  # PATCH/PUT /registry/employee_positions/1.json
  def update
    respond_to do |format|
      if @registry_employee_position.update(registry_employee_position_params)
        format.html { redirect_to @registry_employee_position, notice: 'Cargo fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_employee_position }
      else
        format.html { render :edit }
        format.json { render json: @registry_employee_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/employee_positions/1
  # DELETE /registry/employee_positions/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_employee_positions_url, notice: 'Cargo fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_employee_position_ids].each do |id|
      @cie_resource = Registry::EmployeePosition.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_employee_positions_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_employee_position
      @registry_employee_position = Registry::EmployeePosition.find(params[:id])
    end
    def resource_params
      registry_employee_position_params
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_employee_position_params
      params.require(:registry_employee_position).permit(:name, :description)
    end
end
