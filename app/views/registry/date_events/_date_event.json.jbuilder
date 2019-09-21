date_format = date_event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id date_event.id
json.title date_event.name
json.start date_event.start_time.strftime(date_format)
json.end date_event.end_time.strftime(date_format)

json.color date_event.color unless date_event.color.blank?
json.textColor date_event.text_color_hash["#{date_event.color}"] unless date_event.color.blank?
json.allDay date_event.all_day_event? ? true : false

json.update_url registry_date_event_path(date_event, method: :patch)
json.edit_url edit_registry_date_event_path(date_event)