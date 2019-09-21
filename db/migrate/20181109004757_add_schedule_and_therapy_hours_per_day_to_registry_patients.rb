class AddScheduleAndTherapyHoursPerDayToRegistryPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patients, :schedule, :string
    add_column :registry_patients, :therapy_hours_per_day, :integer
  end
end
