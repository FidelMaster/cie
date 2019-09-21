class Registry::PatientsController < Registry::AuthorizeController
  layout "registry/dashboard_layout"
  before_action :set_registry_patient, only: [:show, :edit, :update, :destroy]
  before_action :set_custom_registry_patient, only: [:assistance, :new_assistance_registration, 
      :edit_assistance_registration, :date_schedule, 
      :medical_record, :destroy_asssitance, :print_assistance, :print_patient]
  before_action :set_registry_patient_assistance, only: [:destroy_assistance, :edit_assistance_registration]

  # GET /registry/patients
  # GET /registry/patients.json
  def index
    @registry_patients = filtering_params(params).paginate(:page => params[:page])
  end

  def date_schedule
  end

  def assistance
    resource = @registry_patient.registry_patient_assistances.order("assistance_date desc")
    @registry_patient_assistances = filtering_assistance_params(params, resource).paginate(:page => params[:page])
  end

  def edit_assistance_registration

  end

  def new_assistance_registration
    @registry_patient.registry_patient_assistances.build
    @registry_patient_assistance = @registry_patient.registry_patient_assistances.last
  end

  def medical_record
    Registry::TherapyType.all.each do |therapy_type|
      if @registry_patient.registry_medical_records.where(:registry_therapy_type_id => therapy_type.id).blank?
        @registry_patient.registry_medical_records.build
        @registry_patient.registry_medical_records.last.registry_therapy_type_id = therapy_type.id
        @registry_patient.registry_medical_records.last.week_therapy_hours || @registry_patient.registry_medical_records.last.week_therapy_hours = 0
      end
    end

    @registry_patient.build_registry_treatment_requirement if @registry_patient.registry_treatment_requirement.blank?

  end

  def filtering_params(params)
    if params[:filter].present?
      Registry::Patient.filter(params[:filter].slice(:patient, :condition, :gender, :status, 
        :department, :district, :school_insurance, :permission_to_take_photos, :informed_consent, :patient_type))
    else
      Registry::Patient.all.order(:id, :patient_state)
    end
  end

  def filtering_assistance_report_params(params, resource)
    if params[:filter].present?
      params[:filter][:assistance_date] = [params[:filter][:start_date],params[:filter][:end_date]]
      resource.filter(params[:filter].slice(:assistance_date))
   else
      resource
    end
  end

  def filtering_assistance_params(params, resource)
    if params[:filter].present?
      operator = params[:filter][:operator]
      if operator.present? and params[:filter][:assist_date].present?
        params[:filter][:operator_filter] = [params[:filter][:operator],params[:filter][:assist_date]]
      end
      resource.filter(params[:filter].slice(:employee, :tutor, :scenario, :operator_filter))
    else
      resource
    end
  end

  # GET /registry/patients/1
  # GET /registry/patients/1.json
  def show
  end

  # GET /registry/patients/new
  def new
    @registry_patient = Registry::Patient.new
  end

  # GET /registry/patients/1/edit
  def edit

  end

  # POST /registry/patients
  # POST /registry/patients.json
  def create
    @registry_patient = Registry::Patient.new(registry_patient_params)

    respond_to do |format|
      if @registry_patient.save
        if registry_patient_params[:registry_patient_assistances_attributes].present?
          format.html { redirect_to registry_patient_assistance_path(@registry_patient.id), notice: 'Asistencia del paciente fue creado exitosamente.' }
        else
          format.html { redirect_to @registry_patient, notice: 'Paciente fue creado exitosamente.' }
        end
        format.json { render :show, status: :created, location: @registry_patient }
      else
        if registry_patient_params[:registry_patient_assistances_attributes].present?
          format.html { render :new_assistance_registration }    
        else
          format.html { render :new }
        end
        format.json { render json: @registry_patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registry/patients/1
  # PATCH/PUT /registry/patients/1.json
  def update

    #Districts only available for Managua, with id 80
    if params[:registry_patient][:registry_municipality_id] != '80'
      params[:registry_patient][:district] = ''
    end

    respond_to do |format|
      if @registry_patient.update(registry_patient_params)
        if registry_patient_params[:registry_patient_assistances_attributes].present?
          format.html { redirect_to registry_patient_assistance_path(@registry_patient.id), notice: 'Asistencia del paciente fue Actualizado exitosamente.' }
        else
          format.html { redirect_to @registry_patient, notice: 'Paciente fue actualizado exitosamente.' }
        end
      else
        if params[:registry_patient].present? && params[:registry_patient][:registry_patient_assistances_attributes].present?
          record = params[:registry_patient][:registry_patient_assistances_attributes]["0"]
          params[:assistance_id] = record["id"]
          
          if params[:assistance_id].present?
            @registry_patient_assistance = Registry::PatientAssistance.find(params[:assistance_id])
          else
            @registry_patient.registry_patient_assistances.build()
            @registry_patient_assistance = @registry_patient.registry_patient_assistances.last
          end
          @registry_patient_assistance.tutor = record["tutor"] if record["assistance_date"].present?
          @registry_patient_assistance.personal_code = record["personal_code"] if record["assistance_date"].present?
          # No longer required
          # @registry_patient_assistance.registry_employee_id = record["registry_employee_id"] if record["assistance_date"].present?
          @registry_patient_assistance.employee_who_receives_id = record["employee_who_receives_id"] if record["assistance_date"].present?
          @registry_patient_assistance.employee_who_delivers_id = record["employee_who_delivers_id"] if record["assistance_date"].present?
          @registry_patient_assistance.assistance_date = record["assistance_date"] if record["assistance_date"].present?
          # No longer required
          # @registry_patient_assistance.scenario = record["scenario"] if record["assistance_date"].present?
        end
        if registry_patient_params[:registry_patient_assistances_attributes].present?
          format.html { render :edit_assistance_registration}    
        else
          format.html { render :edit }
        end
        format.json { render json: @registry_patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registry/patients/1
  # DELETE /registry/patients/1.json
  def destroy
    @cie_resource.destroy
    respond_to do |format|
      format.html { redirect_to registry_patients_url, notice: 'Paciente fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_assistance
    @registry_patient_assistance.destroy
    respond_to do |format|
      format.html { redirect_to registry_patient_assistance_url, notice: 'Asistencia del paciente fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    params[:registry_patient_ids].each do |id|
      @cie_resource = Registry::Patient.find(id)
      @cie_resource.destroy
    end
    respond_to do |format|
      format.html { redirect_to registry_patients_path, notice: 'Registros eliminados exitosamente.'}
      format.json { head :no_content }
    end
  end

  def print_assistance
    resource = @registry_patient.registry_patient_assistances.order("assistance_date desc")
    @patient_assistance = filtering_assistance_report_params(params, resource).group("registry_patient_assistances.id")
    if params[:filter].present?
      @start_date = params[:filter][:start_date]
      @end_date = params[:filter][:end_date]
    end
    
    respond_to do |format|
      format.pdf do
        render pdf: "#{@registry_patient.id}_asistencia_"+Time.now.to_s, orientation: 'Landscape'
      end
      format.xlsx do
        render xlsx: 'print_assistance', filename: 'asistencia-'+@registry_patient.display_name.parameterize+'.xlsx'
      end
    end

  end

  # def print_invoice
  #   if params[:filter].present?
  #     @start_date = params[:filter][:start_date].to_date
  #     @end_date = params[:filter][:end_date].to_date
  #     # @patient_type = params[:filter][:patient_type] if params[:filter][:patient_type].present?
  #     # @invoice_code = params[:filter][:invoice_code] if params[:filter][:invoice_code].present?
  #     # #patient_id = params[:filter][:registry_patient_id] if params[:filter][:registry_patient_id].present?
  #     # @patient_name = params[:filter][:patient_name] if params[:filter][:patient_name].present?
  #     @service = params[:filter][:services] if params[:filter][:services].present?
      
  #     @patients = occurrences.map { |occurrence| occurrence.registry_event }.uniq
  #     .map { |event| event.registry_patients }.uniq.flatten.uniq
  #     @therapy = Registry::TherapyType.find(@service)
  #   end
  #   #@invoice_record = Hash.new
  #   #@patient_hour_record = Hash.new
  #   #@records = Registry::Patient



  # end

  def print_invoice
    if params[:filter].present?
      @start_date = params[:filter][:start_date].to_date
      @end_date = params[:filter][:end_date].to_date
      @patient_type = params[:filter][:patient_type] if params[:filter][:patient_type].present?
      @invoice_code = params[:filter][:invoice_code] if params[:filter][:invoice_code].present?
      patient_id = params[:filter][:registry_patient_id] if params[:filter][:registry_patient_id].present?
      @patient_name = params[:filter][:patient_name] if params[:filter][:patient_name].present?
      @services = params[:filter][:services] if params[:filter][:services].present?
      occurrences = Registry::Occurrence.set_occurrences(@start_date, @end_date)
      @calendar_registry_events = occurrences
      
    end
    if patient_id.present? 
      if @patient_type.present?
        resource = Registry::Patient.where(' "registry_patients"."id" = ? AND "registry_patients"."patient_type" = ?', patient_id, @patient_type)
      else
        resource = Registry::Patient.where(' "registry_patients"."id" = ? AND "registry_patients"."patient_type" IS NOT NULL', patient_id)
      end
    else 
      if @patient_type.present?
        resource = Registry::Patient.joins(:registry_treatment_requirement).where('"registry_treatment_requirements"."beneficiary_social_security_number" IS NOT NULL AND "registry_patients"."patient_type" = ?', @patient_type)
      else
        resource = Registry::Patient.joins(:registry_treatment_requirement).where('"registry_treatment_requirements"."beneficiary_social_security_number" IS NOT NULL AND "registry_patients"."patient_type" IS NOT NULL')
      end
      if @patient_name.present?
        resource = resource.where('"registry_patients"."id" = ? ', @patient_name)
      end
    end
    @patients = resource.where(:patient_state => "Activo").order(:id).distinct
    
    #@invoice_record = Hash.new
    #@patient_hour_record = Hash.new
    @records = Registry::Patient

    respond_to do |format|
      format.pdf do
        render pdf: "facturacion_"+Time.now.to_s, orientation: 'Landscape', footer: { right: 'Página [page] de [topage]' }
      end
      format.xlsx do 
        render xlsx: 'print_invoice', filename: "facturacion_"+Time.now.to_s+'.xlsx'
      end
    end

  end

  # New requirement November 2nd, 2018
  def print_patient
    @medical_record = []
    @registry_patient.registry_medical_records.each do |medical_record|
      @medical_record << { therapy_name: Registry::TherapyType.find(medical_record.registry_therapy_type_id).display_name, weekly_hours: medical_record.week_therapy_hours.to_s }
    end
    respond_to do |format|
      format.pdf do 
        render pdf: @registry_patient.display_name.split.join('-'), orientation: 'Portrait'
      end
      format.xlsx do
        render xlsx: 'print_patient', filename: @registry_patient.display_name.split.join('-')+'.xlsx'
      end
    end
  end
  # end 

  def load_municipalities
    @municipalities = Registry::Department.find(params[:registry_department_id]).registry_municipalities
    @selected_municipality = params[:registry_municipality_id]
    respond_to do |format|
      format.js
    end
  end

  private
    def set_custom_registry_patient
      @registry_patient = Registry::Patient.find(params[:patient_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_registry_patient
      @registry_patient = Registry::Patient.find(params[:id])
    end

    def set_registry_patient_assistance
      @registry_patient_assistance = Registry::PatientAssistance.find(params[:assistance_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      registry_patient_params
    end
    def registry_patient_params
      params.require(:registry_patient).permit(:first_name, :last_name, :birth_date, 
        :gender, :mother_name, :father_name, :email, :phone, :mobile_phone, :patient_type, 
        :medical_start_date, :medical_end_date, :patient_state, :registry_department_id, 
        :registry_municipality_id,
        # New attributes October 2018
        :district,
        :father_id,
        :mother_id,
        :first_guardian_id,
        :first_guardian_name,
        :second_guardian_name,
        :second_guardian_id,
        # end
        :registry_condition_id, :reference_to_center, :address, :comments, 
        :child_avatar,
        :registry_medical_records_attributes => [:week_therapy_hours, 
          :registry_therapy_type_id, :_destroy, :id],
        :registry_treatment_requirement_attributes => [:insured_tutor_number, :other_studies,
          :epicrisis, :birth_certificate, :beneficiary_child_license, 
          :active_secured_parent_id_card, :active_secured_parent_license, 
          :payment_receipt_inss, :entrance_letter, 
          # New requirements November 2nd, 2018
          :informed_consent,
          :permission_to_take_photos,
          :school_insurance,
          :schedule,
          :therapy_hours_per_day,
          # end
          :beneficiary_social_security_number, :_destroy, :id],
        :registry_patient_assistances_attributes => [:personal_code, 
          #:scenario, 
          #:registry_employee_id, 
          :assistance_date,
          # New requirements October 2018
          :employee_who_receives_id,
          :employee_who_delivers_id,
          :received_at,
          :delivered_at, 
          # end
          :tutor, :_destroy, :id])
    end
end
