class Registry::EventsController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_event, only: [:show, :edit, :update, :destroy]

  # GET /registry/events
  # GET /registry/events.json
  def index
    @registry_events = filtering_params(params)
    @calendar_registry_events = @registry_events.flat_map{ |e| e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date)}
    if params[:filter].present? 
      @patient = params[:filter][:patient] || ''
      @employee = params[:filter][:employee] || ''
      @therapy_room = params[:filter][:employee] || ''
    end
  end

  def filtering_params(params)
    if params[:filter].present?
      Registry::Event.filter(params[:filter].slice(:employee, :therapy_room, :patient, :therapy_group_id))
    else
      Array.new
    end
  end

  # GET /registry/events/1
  # GET /registry/events/1.json
  def show
  end

  # GET /registry/events/new
  def new
    @registry_event = Registry::Event.new
    if params[:filter].present?
      @registry_event.registry_employee_id = params[:filter][:employee]
      @registry_event.registry_therapy_room_id = params[:filter][:therapy_room]
    end
  end

  # GET /registry/events/1/edit
  def edit
  end

  # POST /registry/events
  # POST /registry/events.json
  def create
    @registry_event = Registry::Event.new
    times = registry_event_params[:times].split(',').map! { |time| Time.parse(time).seconds_since_midnight.seconds }
    saved = false
    
    times.each do |time|
      @registry_event = Registry::Event.new(registry_event_params.except :registry_event_patients_attributes, :times)
      @registry_event.start_time = @registry_event.start_time.to_datetime + time
      if registry_event_params[:registry_event_patients_attributes]
        @registry_event.registry_event_patients.delete_all
        registry_event_params[:registry_event_patients_attributes][:registry_patient_ids].each do |patient|
          @registry_event.registry_patients << Registry::Patient.find(patient)
        end
      end
      if @registry_event.save
        saved = true
      end
    end

    @selected_patient = Registry::Event.last.registry_event_patients.map{|b| b.registry_patient_id.to_s}
    
    respond_to do |format|
      if saved
        format.html { redirect_to registry_events_path, notice: 'Evento fue creado exitosamente.' }
        format.json { render :show, status: :created, location: Registry::Event.last }
      else
        format.html { render :new }
        format.json { render json: @registry_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/events/1
  # PATCH/PUT /registry/events/1.json
  def update

    if registry_event_params[:registry_event_patients_attributes]
      @registry_event.registry_event_patients.delete_all
      registry_event_params[:registry_event_patients_attributes][:registry_patient_ids].each do |patient|
        @registry_event.registry_patients << Registry::Patient.find(patient)
      end
    end

    @selected_patient = @registry_event.registry_event_patients.map{|b| b.registry_patient_id.to_s}

    respond_to do |format|
      if @registry_event.update(registry_event_params.except :registry_event_patients_attributes)
        format.html { redirect_to @registry_event, notice: 'Evento fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @registry_event }
      else
        format.html { render :edit }
        format.json { render json: @registry_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def load_therapy_group
    @therapy_group = Registry::Employee.find(params[:registry_employee_id]).registry_therapy_group.to_json
    render json: @therapy_group
  end

  def load_therapy_room
    @therapy_room = Registry::TherapyGroup.find(params[:registry_therapy_group_id]).registry_therapy_rooms
    @selected_room_id = params[:room_id]
    puts">>>#{@selected_room_id}"
    respond_to do |format|
      format.js
    end
  end
  # DELETE /registry/events/1
  # DELETE /registry/events/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to "#{registry_events_path}?filter[employee]=#{@cie_resource.registry_employee.id}", notice: 'Evento fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_event_ids].each do |id|
      @cie_resource = Registry::Event.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to "#{registry_events_path}?filter[employee]=#{@cie_resource.registry_employee.id}", notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_event
      @registry_event = Registry::Event.find(params[:id])
      @selected_patient = @registry_event.registry_event_patients.map{|b| b.registry_patient_id.to_s}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      registry_event_params.except :registry_event_patients_attributes
    end
    def registry_event_params
      params.require(:registry_event).permit(:name, :start_time, 
        :end_time, :recurring, :registry_employee_id, 
        :registry_therapy_room_id,
        :registry_therapy_group_id,
        :times,
        :registry_event_patients_attributes => [{:registry_patient_ids=>[]}, :id])
    end
end
