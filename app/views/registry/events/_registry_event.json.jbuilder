json.extract! registry_event, :id, :name, :start_time, :recurring, :created_at, :updated_at
json.url registry_event_url(registry_event, format: :json)
