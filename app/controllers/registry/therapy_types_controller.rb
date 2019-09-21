class Registry::TherapyTypesController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_therapy_type, only: [:show, :edit, :update, :destroy]

  # GET /registry/therapy_types
  # GET /registry/therapy_types.json
  def index
    @registry_therapy_types = Registry::TherapyType.paginate(:page => params[:page])
  end

  # GET /registry/therapy_types/1
  # GET /registry/therapy_types/1.json
  def show
  end

  # GET /registry/therapy_types/new
  def new
    @registry_therapy_type = Registry::TherapyType.new
  end

  # GET /registry/therapy_types/1/edit
  def edit
  end

  # POST /registry/therapy_types
  # POST /registry/therapy_types.json
  def create
    @registry_therapy_type = Registry::TherapyType.new(registry_therapy_type_params)

    respond_to do |format|
      if @registry_therapy_type.save
        format.html { redirect_to @registry_therapy_type, notice: 'Tipo de terapia fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_therapy_type }
      else
        format.html { render :new }
        format.json { render json: @registry_therapy_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/therapy_types/1
  # PATCH/PUT /registry/therapy_types/1.json
  def update
    respond_to do |format|
      if @registry_therapy_type.update(registry_therapy_type_params)
        format.html { redirect_to @registry_therapy_type, notice: 'Tipo de terapia fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_therapy_type }
      else
        format.html { render :edit }
        format.json { render json: @registry_therapy_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/therapy_types/1
  # DELETE /registry/therapy_types/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_therapy_types_url, notice: 'Tipo de terapia fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_therapy_type_ids].each do |id|
      @cie_resource = Registry::TherapyType.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_therapy_types_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_therapy_type
      @registry_therapy_type = Registry::TherapyType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      registry_therapy_type_params
    end
    def registry_therapy_type_params
      params.require(:registry_therapy_type).permit(:name, 
        :description, :private_therapy_price, :inss_therapy_price,
        :label_color)
    end
end
