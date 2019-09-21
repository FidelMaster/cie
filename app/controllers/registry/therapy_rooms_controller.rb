class Registry::TherapyRoomsController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_therapy_room, only: [:show, :edit, :update, :destroy]

  # GET /registry/therapy_rooms
  # GET /registry/therapy_rooms.json
  def index
    @registry_therapy_rooms = Registry::TherapyRoom.paginate(:page => params[:page])
  end

  # GET /registry/therapy_rooms/1
  # GET /registry/therapy_rooms/1.json
  def show
  end

  # GET /registry/therapy_rooms/new
  def new
    @registry_therapy_room = Registry::TherapyRoom.new
  end

  # GET /registry/therapy_rooms/1/edit
  def edit
  end

  # POST /registry/therapy_rooms
  # POST /registry/therapy_rooms.json
  def create
    @registry_therapy_room = Registry::TherapyRoom.new(registry_therapy_room_params)

    respond_to do |format|
      if @registry_therapy_room.save
        format.html { redirect_to @registry_therapy_room, notice: 'Salón fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @registry_therapy_room }
      else
        format.html { render :new }
        format.json { render json: @registry_therapy_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/therapy_rooms/1
  # PATCH/PUT /registry/therapy_rooms/1.json
  def update
    respond_to do |format|
      if @registry_therapy_room.update(registry_therapy_room_params)
        format.html { redirect_to @registry_therapy_room, notice: 'Salón fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_therapy_room }
      else
        format.html { render :edit }
        format.json { render json: @registry_therapy_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/therapy_rooms/1
  # DELETE /registry/therapy_rooms/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_therapy_rooms_url, notice: 'Salón fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_therapy_room_ids].each do |id|
      @cie_resource = Registry::TherapyRoom.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_therapy_rooms_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_therapy_room
      @registry_therapy_room = Registry::TherapyRoom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      registry_therapy_room_params
    end
    def registry_therapy_room_params
      params.require(:registry_therapy_room).permit(:name, :description, :capacity, :registry_therapy_type_id, :registry_level_id)
    end
end
