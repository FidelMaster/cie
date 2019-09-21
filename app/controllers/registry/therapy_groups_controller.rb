class Registry::TherapyGroupsController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_therapy_group, only: [:show, :edit, :update, :destroy]

  # GET /registry/therapy_groups
  # GET /registry/therapy_groups.json
  def index
    @registry_therapy_groups = Registry::TherapyGroup.all.paginate(:page => params[:page])
  end

  # GET /registry/therapy_groups/1
  # GET /registry/therapy_groups/1.json
  def show
  end

  # GET /registry/therapy_groups/new
  def new
    @registry_therapy_group = Registry::TherapyGroup.new
  end

  # GET /registry/therapy_groups/1/edit
  def edit
  end

  # POST /registry/therapy_groups
  # POST /registry/therapy_groups.json
  def create

    @registry_therapy_group = Registry::TherapyGroup.new(registry_therapy_group_params.except :registry_therapy_group_rooms_attributes)
    
    if registry_therapy_group_params[:registry_therapy_group_rooms_attributes]
      @registry_therapy_group.registry_therapy_group_rooms.delete_all
      registry_therapy_group_params[:registry_therapy_group_rooms_attributes][:registry_therapy_room_ids].each do |therapy_room|
        @registry_therapy_group.registry_therapy_rooms << Registry::TherapyRoom.find(therapy_room)
      end
    end

    respond_to do |format|
      if @registry_therapy_group.save
        format.html { redirect_to @registry_therapy_group, notice: 'Grupo de terapia fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_therapy_group }
      else
        format.html { render :new }
        format.json { render json: @registry_therapy_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/therapy_groups/1
  # PATCH/PUT /registry/therapy_groups/1.json
  def update
    
    if registry_therapy_group_params[:registry_therapy_group_rooms_attributes]
      @registry_therapy_group.registry_therapy_group_rooms.delete_all
      registry_therapy_group_params[:registry_therapy_group_rooms_attributes][:registry_therapy_room_ids].each do |therapy_room|
        @registry_therapy_group.registry_therapy_rooms << Registry::TherapyRoom.find(therapy_room)
      end
    end

    respond_to do |format|
      if @registry_therapy_group.update(registry_therapy_group_params.except :registry_therapy_group_rooms_attributes)
        format.html { redirect_to @registry_therapy_group, notice: 'Grupo de terapia fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_therapy_group }
      else
        format.html { render :edit }
        format.json { render json: @registry_therapy_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/therapy_groups/1
  # DELETE /registry/therapy_groups/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_therapy_groups_url, notice: 'Grupo de terapia fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_therapy_group_ids].each do |id|
      @cie_resource = Registry::TherapyGroup.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_therapy_groups_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_therapy_group
      @registry_therapy_group = Registry::TherapyGroup.find(params[:id])
      @selected_therapy_room = @registry_therapy_group.registry_therapy_group_rooms.map{|b| b.registry_therapy_room_id.to_s}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      registry_therapy_group_params.except :registry_therapy_group_rooms_attributes
    end
    def registry_therapy_group_params
      params.require(:registry_therapy_group).permit(:name, :description,
        :registry_therapy_group_rooms_attributes => [{:registry_therapy_room_ids=>[]}, :id])
    end
end
