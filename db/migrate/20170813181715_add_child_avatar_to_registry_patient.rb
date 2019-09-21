class AddChildAvatarToRegistryPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :registry_patients, :child_avatar, :string
  end
end
