class Registry::AgeRangesController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_age_range, only: [:show, :edit, :update, :destroy]

  # GET /registry/age_ranges
  # GET /registry/age_ranges.json
  def index
    @registry_age_ranges = Registry::AgeRange.paginate(:page => params[:page])
  end

  # GET /registry/age_ranges/1
  # GET /registry/age_ranges/1.json
  def show
  end

  # GET /registry/age_ranges/new
  def new
    @registry_age_range = Registry::AgeRange.new
  end

  # GET /registry/age_ranges/1/edit
  def edit
  end

  # POST /registry/age_ranges
  # POST /registry/age_ranges.json
  def create
    @registry_age_range = Registry::AgeRange.new(registry_age_range_params)

    respond_to do |format|
      if @registry_age_range.save
        format.html { redirect_to @registry_age_range, notice: 'Rango de edad fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_age_range }
      else
        format.html { render :new }
        format.json { render json: @registry_age_range.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/age_ranges/1
  # PATCH/PUT /registry/age_ranges/1.json
  def update
    respond_to do |format|
      if @registry_age_range.update(registry_age_range_params)
        format.html { redirect_to @registry_age_range, notice: 'Rango de edad fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_age_range }
      else
        format.html { render :edit }
        format.json { render json: @registry_age_range.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_age_ranges_url, notice: 'Rango de edad fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_age_range_ids].each do |id|
      @cie_resource = Registry::AgeRange.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_age_ranges_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_age_range
      @registry_age_range = Registry::AgeRange.find(params[:id])
    end
    def resource_params
      registry_age_range_params
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_age_range_params
      params.require(:registry_age_range).permit(:name, :description, :min_age, :max_age)
    end
end
