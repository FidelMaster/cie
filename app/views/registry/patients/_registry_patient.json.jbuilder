json.extract! registry_patient, :id, :first_name, :last_name, :birth_date, :gender, :created_at, :updated_at
json.url registry_patient_url(registry_patient, format: :json)
