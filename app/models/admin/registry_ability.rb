class Admin::RegistryAbility < Ability
  def initialize(user)
    user ||= Registry::CieUser.new
    permissions = Admin::CieRolePermission.joins(%{INNER JOIN registry_cie_users_registry_cie_roles
                                                      ON admin_cie_role_permissions.admin_cie_role_id = registry_cie_users_registry_cie_roles.admin_cie_role_id
                                                      AND registry_cie_users_registry_cie_roles.registry_cie_user_id = #{user.id} }.gsub(/\s+/, ' ' ))
    permissions.each do |permission|
      	can eval_cancan_action(permission.admin_action.name).to_sym, permission.admin_resource.model.constantize
      	if can? :destroy, permission.admin_resource.model.constantize
      		can :destroy_multiple, permission.admin_resource.model.constantize
      	end
      	#cancan_action = "destroy_multiple"
	end
	
    if can? :read, Registry::Patient
	    can :print_invoice, Registry::Patient
	    can :assistance, Registry::Patient
	    can :print_assistance, Registry::Patient
		can :medical_record, Registry::Patient
		can :print_patient, Registry::Patient
		can :new_assistance_registration, Registry::Patient
		can :date_schedule, Registry::Patient
	end

	if can? :destroy, Registry::Patient
		can :destroy_assistance, Registry::Patient
	end
	if can? :update, Registry::Patient
		can :edit_assistance_registration, Registry::Patient
		can :load_municipalities, Registry::Patient
		can :load_boss, Registry::Employee
	end
	if can? :create, Registry::Event
		can :load_therapy_group, Registry::Event
		can :load_therapy_room, Registry::Event
		can :load_boss, Registry::Employee
		can :print_report, Registry::Event
	end
  end

  	def eval_cancan_action(action)
		case action.to_s
			when "index", "show", "search"
				cancan_action = "read"
				#action_desc = I18n.t :read
			when "create", "new"
				cancan_action = "create"
				#action_desc = I18n.t :create
			when "edit", "update"
				cancan_action = "update"
				#action_desc = I18n.t :edit
			when "delete", "destroy"
				cancan_action = "destroy"
				#action_desc = I18n.t :delete
			else
				cancan_action = action.to_s
				#action_desc = "Other: " << cancan_action
		end
		return cancan_action #action_desc, 
	end
end
