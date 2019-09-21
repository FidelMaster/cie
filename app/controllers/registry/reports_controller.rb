class Registry::ReportsController < Registry::AuthorizeController
  #before_action :set_registry_report, only: [:show, :edit, :update, :destroy]
  skip_load_and_authorize_resource
  authorize_resource :class => false

  layout "registry/dashboard_layout"
  # GET /registry/reports
  # GET /registry/reports.json
  def index
    redirect_to registry_root_path
  end

  # GET /registry/reports/1
  # GET /registry/reports/1.json
  def show
    redirect_to registry_reports_url
  end

  # GET /registry/reports/new
  def new
    redirect_to registry_reports_url
  end

  # GET /registry/reports/1/edit
  def edit
    redirect_to registry_reports_url
  end

  # POST /registry/reports
  # POST /registry/reports.json
  def create
   redirect_to registry_reports_url
  end

  # PATCH/PUT /registry/reports/1
  # PATCH/PUT /registry/reports/1.json
  def update
    redirect_to registry_reports_url
  end

  # DELETE /registry/reports/1
  # DELETE /registry/reports/1.json
  def destroy
    redirect_to registry_reports_url
  end



  
  def get_scene
    puts "Estoy aqui"
    data = params[:filter][:symbol].to_s
   
    case data
      when "therapy_group"
        id_p = params[:filter][data].to_i
        puts "Estoy aqyuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu"
        puts id_p
       
        @scene_id = id_p
        scene = Registry::TherapyGroup.where(id: id_p).select('name', 'id')
        @employees = Registry::Employee.employers_from_group(@scene_id)
        puts @employees
       # @emID = Registry::Employee.id(@scene_id)
       #Horas asignadas 
        @horasA=Registry::Employee.HorasAsignadas(@start_date,@end_date,42,@scene_id)
        @horasC=Registry::Employee.HorasCumplida(@start_date,@end_date,42,@scene_id)

        respond_to do |format|
    
          format.pdf do
           render pdf: "#{@report_scenario}_agenda_"+Time.now.to_s, orientation: 'Landscape', footer: { right: 'Pagina [page] de [topage]' }
           end
        
        # @report_scenario = Registry::TherapyGroup.
      end
      @report_scene = scene[0]["name"]
    end
  end

  def _week_covered_hours_employee
    puts "me quede aqui"
   
  end
    


  def print_report
    
    @start_date = params[:filter][:start_date].to_date
    @end_date = params[:filter][:end_date].to_date
    occurrences = Array.new
    
    @weeks_with_days = Registry::Event.days_of_the_week(@start_date, @end_date)
    
    @coordinador = Registry::Employee.where(
      :registry_employee_position_id => Registry::EmployeePosition.where(name: "Coordinador").pluck(:id))
      
    @employees_coordinador = Registry::Employee.where(boss_id: @coordinador)
    
    @registry_events = filtering_params(params, params[:filter][:symbol].to_sym)

    #if @registry_events
    #@registry_events = Registry::Event.where("registry_employee_id in (?) or 
    #registry_employee_id in (?) ", @coordinador.select(:id).uniq, @employees_coordinador.select(:id).uniq )
    # if params[:filter][:symbol].to_sym == :coordinador_covered_hour
    
    @occurrences = Registry::Occurrence.set_occurrences(@start_date, @end_date)  
    #filter like linq
    #@calendar_registry_events.select { |event| event.start_time >= @start_date.to_date && event.start_time <= @end_date.to_date }

    @report_scenario = get_scene
    # @report_scenario = Registry::TherapyGroup.find(params[:filter][:therapy_group]).select('display_name, id') if params[:filter][:therapy_group].present?
    @report_scenario = Registry::Employee.find(params[:filter][:employee]).select('display_name, id') if params[:filter][:employee].present?
    @report_scenario = Registry::Patient.find(params[:filter][:patient]).select('display_name, id') if params[:filter][:patient].present?
    @report_scenario = Registry::TherapyRoom.find(params[:filter][:therapy_room]).select('display_name, id') if params[:filter][:therapy_room].present?
    
    @report_type = :hour_report if params[:filter][:hour_report]
    @report_type = :hour_covered_report if params[:filter][:hour_covered_report]
    @report_type = :therapy_group if params[:filter][:therapy_group].present? && !params[:filter][:hour_covered_report] && !params[:filter][:hour_report]
    @report_type = :employee if params[:filter][:employee].present?
    @report_type = :coordinador_covered_report if params[:filter][:coordinador_covered_report]
    
    @report_scenario = "Consolidado Mensual Por Coordinador" if params[:filter][:coordinador_covered_report]
    if params[:filter][:patient].present?
      @patients = Array.new.push(params[:filter][:patient].to_i)
    end

    if params[:filter][:therapy_room].present?
      @rooms = Array.new.push(params[:filter][:therapy_room].to_i)
    end

    if params[:filter][:period].present? && params[:filter][:period].to_sym == :month
      @report_type = :employee_month
    end
    
    @single_report = true if params[:filter][:single].present?
    
    @employees = Array.new
    if @report_type == :employee_month || @report_type == :employee
      
      @employees = Registry::Employee.where("last_name like :query", query: "%#{@report_scenario.split.last}%").pluck(:id).uniq.to_a
      
      #:hour_covered_report
   
     
      #@therapy_id = Registry::TherapyGroup.find_by_name(@report_scenario).registry_therapy_rooms.pluck(:registry_therapy_type_id).uniq.first
    else
      @employees = Registry::Event.where(id: occurrences.pluck(:registry_event_id).uniq)
      .pluck(:registry_employee_id).uniq
    end
    
    if @report_type == :coordinador_covered_report
      @single_report = true
      @employees = Registry::Employee.where(
        id: Registry::Event.where(id: occurrences.pluck(:registry_event_id).uniq)
          .pluck(:registry_employee_id).uniq)
          #don't know a better way
    end
        @utilities = Utilities::Utilities.new
    
  end
  
  
  private

  def filtering_params(params, symbol)
    if params[:filter].present? && params[:filter][symbol].present?
      Registry::Event.filter(params[:filter].slice(symbol))
    else
      false
    end

  end
  # Use callbacks to share common setup or constraints between actions.
    #def set_registry_report
    #  @registry_report = Registry::Report.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def registry_report_params
    #  params.fetch(:registry_report, {})
    #end

end