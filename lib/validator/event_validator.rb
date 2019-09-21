class Validator::EventValidator < ActiveModel::Validator
  def validate(record)
    calendar_array = record.simple_calendar_events_array(record.start_time)
  	record.registry_patients.each do |patient|
      array_patient_comparison = patient.registry_events.scoped_events(record).flat_map{ |e| e.simple_calendar_events_array(record.start_time)} & 
        calendar_array
      unless array_patient_comparison.uniq.blank?
        record.errors[:start_time] << "Existen conflictos con eventos programados para este paciente en el horario y fecha sugerido, ingrese otra hora para este registro"  
      end
	  end
    if record.registry_employee.present?
      array_employee_comparison = record.registry_employee.registry_events.scoped_events(record).flat_map{ |e| e.simple_calendar_events_array(record.start_time)} & 
        calendar_array
      unless array_employee_comparison.uniq.blank?
        record.errors[:start_time] << "Existen conflictos con eventos programados para este colaborador en el horario y fecha sugerido, ingrese otra hora para este registro"  
      end
    end
    if record.registry_event_patients.present? && record.registry_therapy_room.present?
      unless record.registry_event_patients.size <= record.registry_therapy_room.capacity
        record.errors[:registry_therapy_room] << "La capacidad del salón es de #{record.registry_therapy_room.capacity}"
      end
    end
  end
end