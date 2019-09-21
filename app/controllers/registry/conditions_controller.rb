class Registry::ConditionsController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_condition, only: [:show, :edit, :update, :destroy]

  # GET /registry/conditions
  # GET /registry/conditions.json
  def index
    @registry_conditions = Registry::Condition.paginate(:page => params[:page])
  end

  # GET /registry/conditions/1
  # GET /registry/conditions/1.json
  def show
  end

  # GET /registry/conditions/new
  def new
    @registry_condition = Registry::Condition.new
  end

  # GET /registry/conditions/1/edit
  def edit
  end

  # POST /registry/conditions
  # POST /registry/conditions.json
  def create
    @registry_condition = Registry::Condition.new(registry_condition_params)

    respond_to do |format|
      if @registry_condition.save
        format.html { redirect_to @registry_condition, notice: 'Condición médica creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_condition }
      else
        format.html { render :new }
        format.json { render json: @registry_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/conditions/1
  # PATCH/PUT /registry/conditions/1.json
  def update
    respond_to do |format|
      if @registry_condition.update(registry_condition_params)
        format.html { redirect_to @registry_condition, notice: 'Condición médica actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_condition }
      else
        format.html { render :edit }
        format.json { render json: @registry_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/conditions/1
  # DELETE /registry/conditions/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_conditions_url, notice: 'Condición médica eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_condition_ids].each do |id|
      @cie_resource = Registry::Condition.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_conditions_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_condition
      @registry_condition = Registry::Condition.find(params[:id])
    end

    def resource_params
      registry_condition_params
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_condition_params
      params.require(:registry_condition).permit(:name, :description)
    end
end
