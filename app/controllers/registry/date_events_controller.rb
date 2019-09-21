class Registry::DateEventsController < Registry::AuthorizeController
  before_action :set_registry_date_event, only: [:show, :edit, :update, :destroy]

  # GET /registry/date_events
  # GET /registry/date_events.json
  def index
    if params[:patient_id].present?
      @registry_date_events = Registry::DateEvent.where(registry_patient_id: params[:patient_id], start_time: params[:start_time]..params[:end_time])
    else
      @registry_date_events = Registry::DateEvent.where(start_time: params[:start_time]..params[:end_time])
    end
  end

  # GET /registry/date_events/1
  # GET /registry/date_events/1.json
  def show
  end

  # GET /registry/date_events/new
  def new
    @registry_date_event = Registry::DateEvent.new
    if params[:patient_id].present?
      @registry_date_event.registry_patient_id = params[:patient_id]
    end
  end

  # GET /registry/date_events/1/edit
  def edit
  end

  # POST /registry/date_events
  # POST /registry/date_events.json
  def create
    @registry_date_event = Registry::DateEvent.new(registry_date_event_params.except :registry_date_event_employees_attributes)
    if registry_date_event_params[:registry_date_event_employees_attributes]
      @registry_date_event.registry_date_event_employees.delete_all
      registry_date_event_params[:registry_date_event_employees_attributes][:registry_employee_ids].each do |employee|
        @registry_date_event.registry_employees << Registry::Employee.find(employee)
      end
    end

    @selected_employee = @registry_date_event.registry_date_event_employees.map{|b| b.registry_employee_id.to_s}
    
    @registry_date_event.save
    date_mailer_sender(@registry_date_event)
  end

  # PATCH/PUT /registry/date_events/1
  # PATCH/PUT /registry/date_events/1.json
  def update
    if registry_date_event_params[:registry_date_event_employees_attributes]
      @registry_date_event.registry_date_event_employees.delete_all
      registry_date_event_params[:registry_date_event_employees_attributes][:registry_employee_ids].each do |employee|
        @registry_date_event.registry_employees << Registry::Employee.find(employee)
      end
    else
      @registry_date_event.registry_date_event_employees.delete_all
    end

    @selected_employee = @registry_date_event.registry_date_event_employees.map{|b| b.registry_employee_id.to_s}

    @registry_date_event.update(registry_date_event_params.except :registry_date_event_employees_attributes)
    date_mailer_sender(@registry_date_event)
  end

  # DELETE /registry/date_events/1
  # DELETE /registry/date_events/1.json
  def destroy
    @registry_date_event.destroy
  end

  def date_mailer_sender(registry_date_event)
    # persons = Registry::CieUser.where(is_evaluator: true)
    employees = registry_date_event.registry_employees
    # if persons.present?
    #   begin
    #     DateEventMailer.date_sender(persons, 
    #         @registry_date_event)
    #   rescue Exception
    #    raise Exception, "Verifique su configuración de correo electrónico, se presentaron problemas al enviar las notificaciones"
    #   end
    # end
    if employees.present?
        DateEventMailer.date_sender(employees, 
            @registry_date_event)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_date_event
      @registry_date_event = Registry::DateEvent.find(params[:id])
      @selected_employee = @registry_date_event.registry_date_event_employees.map{|b| b.registry_employee_id.to_s}
      puts "empleado >>>>>>>>>> #{@selected_employee}"
    end

    def resource_params
      registry_date_event_params.except :registry_date_event_employees_attributes
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_date_event_params
      params.require(:registry_date_event).permit(:date_range, :registry_patient_id, :name, 
        :description, :start_time, :end_time, :color, :date_event_type, :comments, :billable, :completed_date,
        :child_guardian, :phone_number, :child_name,
        :registry_date_event_employees_attributes => [{:registry_employee_ids=>[]}, :id])
    end
end
