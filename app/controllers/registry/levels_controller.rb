class Registry::LevelsController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_level, only: [:show, :edit, :update, :destroy]

  # GET /registry/levels
  # GET /registry/levels.json
  def index
    @registry_levels = Registry::Level.paginate(:page => params[:page])
  end

  # GET /registry/levels/1
  # GET /registry/levels/1.json
  def show
  end

  # GET /registry/levels/new
  def new
    @registry_level = Registry::Level.new
  end

  # GET /registry/levels/1/edit
  def edit
  end

  # POST /registry/levels
  # POST /registry/levels.json
  def create
    @registry_level = Registry::Level.new(registry_level_params)

    respond_to do |format|
      if @registry_level.save
        format.html { redirect_to @registry_level, notice: 'Área fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_level }
      else
        format.html { render :new }
        format.json { render json: @registry_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/levels/1
  # PATCH/PUT /registry/levels/1.json
  def update
    respond_to do |format|
      if @registry_level.update(registry_level_params)
        format.html { redirect_to @registry_level, notice: 'Área fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_level }
      else
        format.html { render :edit }
        format.json { render json: @registry_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/levels/1
  # DELETE /registry/levels/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_levels_url, notice: 'Área fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_level_ids].each do |id|
      @cie_resource = Registry::Level.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_levels_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_level
      @registry_level = Registry::Level.find(params[:id])
    end

    def resource_params
      registry_level_params
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_level_params
      params.require(:registry_level).permit(:name, :description, :registry_age_range_id)
    end
end
