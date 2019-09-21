# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Admin::ResourceType.all.blank?
	resource_type = Admin::ResourceType.create(:description => "Catálogo")
end

if Admin::Resource.all.blank?
	module_dirs = ['registry']
	module_dirs.each do |module_dir|
		module_name = "#{module_dir}".camelize
		Dir[Rails.root.join("app/models/#{module_dir}/*.rb").to_s].each do |filename|
		  klass = File.basename(filename, '.rb').camelize
			klass_full_name = "#{module_name}::#{klass}"
			next if !klass_full_name.constantize.ancestors.include?(ActiveRecord::Base) || (['Admin::Resource', 'Admin::RegistryAbility', 'Admin::Permission'].include?(klass_full_name))
			puts "saving resource class #{klass_full_name}"
			Admin::Resource.create(:description => klass_full_name,
				:model => klass_full_name,
				:module => module_name,
				:admin_resource_type_id => Admin::ResourceType.first.id)
		end
	end
end

if Admin::Action.all.blank?
	Admin::Action.create(:id => 1, :description => 'index', :name => 'index')
	Admin::Action.create(:id => 2, :description => 'show', :name => 'show')
	Admin::Action.create(:id => 3, :description => 'create', :name => 'create')
	Admin::Action.create(:id => 4, :description => 'update', :name => 'update')
	Admin::Action.create(:id => 5, :description => 'new', :name => 'new')
	Admin::Action.create(:id => 6, :description => 'edit', :name => 'edit')
	Admin::Action.create(:id => 7, :description => 'destroy', :name => 'destroy')
end

if Admin::Permission.all.blank?
	Admin::Action.all.each do |action|
		Admin::Resource.all.each do |admin_resource|
			puts "saving resource permission #{admin_resource.name}"
			Admin::Permission.create(:admin_action_id => action.id, :admin_resource_id => admin_resource.id)
		end
	end
end

if Admin::CieRole.all.blank?
	Admin::CieRole.create(:name => 'registry')
end

if Admin::AdminUser.all.blank?
	admin_user = Admin::AdminUser.create(:email => "admin@example.com", :password => "123456")
	admin_user.save!
end

if Registry::CieUser.all.blank?
	cie_user = Registry::CieUser.create(:name => 'dummy', :email => "admin@example.com", :password => "123456", :admin_cie_role_ids => [Admin::CieRole.first.id])
	cie_user.save!
end

if Registry::Department.all.blank?
	Registry::Department.create(name: "BOACO")
	Registry::Department.create(name: "CARAZO")
	Registry::Department.create(name: "CHINANDEGA")
	Registry::Department.create(name: "CHONTALES")
	Registry::Department.create(name: "ESTELI")
	Registry::Department.create(name: "GRANADA")
	Registry::Department.create(name: "JINOTEGA")
	Registry::Department.create(name: "LEON")
	Registry::Department.create(name: "MADRIZ")
	Registry::Department.create(name: "MANAGUA")
	Registry::Department.create(name: "MASAYA")
	Registry::Department.create(name: "MATAGALPA")
	Registry::Department.create(name: "NUEVA SEGOVIA")
	Registry::Department.create(name: "RAAN")
	Registry::Department.create(name: "RAAS")
	Registry::Department.create(name: "RIO SAN JUAN")
	Registry::Department.create(name: "RIVAS")
end

if Registry::Municipality.all.blank?
	Registry::Municipality.create(name: "Teustepe",:registry_department_id => Registry::Department.where(:name => "BOACO").first.id)
	Registry::Municipality.create(name: "San José de los Remates",:registry_department_id => Registry::Department.where(:name => "BOACO").first.id)
	Registry::Municipality.create(name: "Santa Lucía",:registry_department_id => Registry::Department.where(:name => "BOACO").first.id)
	Registry::Municipality.create(name: "Boaco",:registry_department_id => Registry::Department.where(:name => "BOACO").first.id)
	Registry::Municipality.create(name: "Camoapa",:registry_department_id => Registry::Department.where(:name => "BOACO").first.id)
	Registry::Municipality.create(name: "San Lorenzo",:registry_department_id => Registry::Department.where(:name => "BOACO").first.id)
	Registry::Municipality.create(name: "San Marcos",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "Diriamba",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "Dolores",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "Jinotepe",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "El Rosario",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "La Paz",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "Santa Teresa",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "La Conquista",:registry_department_id => Registry::Department.where(:name => "CARAZO").first.id)
	Registry::Municipality.create(name: "El Viejo",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Puerto Morazán",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Somotillo",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Santo Tomás del Norte",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Cinco Pinos",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "San Pedro del Norte",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "San Francisco del Norte",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Corinto",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Villanueva",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Chinandega",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Posoltega",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Chichigalpa",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "El Realejo",:registry_department_id => Registry::Department.where(:name => "CHINANDEGA").first.id)
	Registry::Municipality.create(name: "Comalapa",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Juigalpa",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "La Libertad",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Santo Domingo",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "San Pedro de Lovago",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Santo Tomás",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "El Rama",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Villa Sandino",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Acoyapa",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Cuapa",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "El Coral",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Mueye de los Bueyes",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Nueva Guinea",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "El Ayote",:registry_department_id => Registry::Department.where(:name => "CHONTALES").first.id)
	Registry::Municipality.create(name: "Pueblo Nuevo",:registry_department_id => Registry::Department.where(:name => "ESTELI").first.id)
	Registry::Municipality.create(name: "Condega",:registry_department_id => Registry::Department.where(:name => "ESTELI").first.id)
	Registry::Municipality.create(name: "San Juan de Limay",:registry_department_id => Registry::Department.where(:name => "ESTELI").first.id)
	Registry::Municipality.create(name: "Esteli",:registry_department_id => Registry::Department.where(:name => "ESTELI").first.id)
	Registry::Municipality.create(name: "La Trinidad",:registry_department_id => Registry::Department.where(:name => "ESTELI").first.id)
	Registry::Municipality.create(name: "San Nicolás",:registry_department_id => Registry::Department.where(:name => "ESTELI").first.id)
	Registry::Municipality.create(name: "Granada",:registry_department_id => Registry::Department.where(:name => "GRANADA").first.id)
	Registry::Municipality.create(name: "Diriomo",:registry_department_id => Registry::Department.where(:name => "GRANADA").first.id)
	Registry::Municipality.create(name: "Diriá",:registry_department_id => Registry::Department.where(:name => "GRANADA").first.id)
	Registry::Municipality.create(name: "Nandaime",:registry_department_id => Registry::Department.where(:name => "GRANADA").first.id)
	Registry::Municipality.create(name: "La Concordia",:registry_department_id => Registry::Department.where(:name => "JINOTEGA").first.id)
	Registry::Municipality.create(name: "San Sebastián de Yalí",:registry_department_id => Registry::Department.where(:name => "JINOTEGA").first.id)
	Registry::Municipality.create(name: "San Rafael del Norte",:registry_department_id => Registry::Department.where(:name => "JINOTEGA").first.id)
	Registry::Municipality.create(name: "Jinotega",:registry_department_id => Registry::Department.where(:name => "JINOTEGA").first.id)
	Registry::Municipality.create(name: "Santa María de Pantasma",:registry_department_id => Registry::Department.where(:name => "JINOTEGA").first.id)
	Registry::Municipality.create(name: "Cuá Bocay",:registry_department_id => Registry::Department.where(:name => "JINOTEGA").first.id)
	Registry::Municipality.create(name: "Wiwilí",:registry_department_id => Registry::Department.where(:name => "JINOTEGA").first.id)
	Registry::Municipality.create(name: "Achuapa",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "El Sauce",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "Santa Rosa del Peñón",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "El Jicaral",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "Larreynaga-Malpaisillo",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "Telica",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "Quezalguaque",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "León",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "La Paz Centro",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "Nagarote",:registry_department_id => Registry::Department.where(:name => "LEON").first.id)
	Registry::Municipality.create(name: "San José de Cusmapa",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "Las Sabanas",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "San Lucas",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "Somoto",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "Totogalpa",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "Yalaguina",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "Palacaguina",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "Telpaneca",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "San Juan de Río Coco",:registry_department_id => Registry::Department.where(:name => "MADRIZ").first.id)
	Registry::Municipality.create(name: "San Francisco Libre",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "Tipitapa",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "Managua",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "San Rafael del Sur",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "Villa Carlos Fonseca",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "El Crucero",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "Mateare",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "Ciudad Sandino",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "Ticuantepe",:registry_department_id => Registry::Department.where(:name => "MANAGUA").first.id)
	Registry::Municipality.create(name: "Tisma",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "Masaya",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "Nindirí",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "La Concepción",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "Masatepe",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "Nandasmo",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "Niquinohomo",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "Catarina",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "San Juan de Oriente",:registry_department_id => Registry::Department.where(:name => "MASAYA").first.id)
	Registry::Municipality.create(name: "Matagalpa",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Sébaco",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "San Isidro",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Ciudad Darío",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Terrabona",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "San Dionisio",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Esquipulas",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Muy-Muy",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "San Ramón",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Matiguás",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Río Blanco",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Rancho Grande",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Tuma La Dalia",:registry_department_id => Registry::Department.where(:name => "MATAGALPA").first.id)
	Registry::Municipality.create(name: "Santa María",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Macuelizo",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Dipilto",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Ocotal",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Mozonte",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "San Fernando",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Jalapa",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Murra",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Wiwili",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "El Jícaro",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Ciudad Antigua",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Quilali",:registry_department_id => Registry::Department.where(:name => "NUEVA SEGOVIA").first.id)
	Registry::Municipality.create(name: "Waslala",:registry_department_id => Registry::Department.where(:name => "RAAN").first.id)
	Registry::Municipality.create(name: "Waspan",:registry_department_id => Registry::Department.where(:name => "RAAN").first.id)
	Registry::Municipality.create(name: "Puerto Cabezas",:registry_department_id => Registry::Department.where(:name => "RAAN").first.id)
	Registry::Municipality.create(name: "Prinzapolka",:registry_department_id => Registry::Department.where(:name => "RAAN").first.id)
	Registry::Municipality.create(name: "Bonanza",:registry_department_id => Registry::Department.where(:name => "RAAN").first.id)
	Registry::Municipality.create(name: "Siuna",:registry_department_id => Registry::Department.where(:name => "RAAN").first.id)
	Registry::Municipality.create(name: "Rosita",:registry_department_id => Registry::Department.where(:name => "RAAN").first.id)
	Registry::Municipality.create(name: "Bocana de Paiwas",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "La Cruz de Río Grande",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "Kukra Hill",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "Laguna de Perlas",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "Bluefields",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "Corn Island",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "El Tortuguero",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "Desembocadura Río Grande",:registry_department_id => Registry::Department.where(:name => "RAAS").first.id)
	Registry::Municipality.create(name: "Morrito",:registry_department_id => Registry::Department.where(:name => "RIO SAN JUAN").first.id)
	Registry::Municipality.create(name: "El Almendro",:registry_department_id => Registry::Department.where(:name => "RIO SAN JUAN").first.id)
	Registry::Municipality.create(name: "San Miguelito",:registry_department_id => Registry::Department.where(:name => "RIO SAN JUAN").first.id)
	Registry::Municipality.create(name: "San Carlos",:registry_department_id => Registry::Department.where(:name => "RIO SAN JUAN").first.id)
	Registry::Municipality.create(name: "El Castillo",:registry_department_id => Registry::Department.where(:name => "RIO SAN JUAN").first.id)
	Registry::Municipality.create(name: "San Juan del Norte",:registry_department_id => Registry::Department.where(:name => "RIO SAN JUAN").first.id)
	Registry::Municipality.create(name: "Tola",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "Belén",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "Potosí",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "Buenos Aires",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "San Jorge",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "Rivas",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "San Juan del Sur",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "Cardenas",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "Moyogalpa",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
	Registry::Municipality.create(name: "Altagracia",:registry_department_id => Registry::Department.where(:name => "RIVAS").first.id)
end


if Admin::Parameter.all.blank?
	Admin::Parameter.create(name: "Cita",:inss_hour_price => 0, :private_hour_price => 0, :is_eval => true)
	Admin::Parameter.create(name: "Evaluación",:inss_hour_price => 0, :private_hour_price => 0, :is_eval => true)
end