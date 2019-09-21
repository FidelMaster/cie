Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root :to => "home#index"

	namespace :administration do
		devise_for :users, class_name: "User::User"
		root :to => "/administration/dashboard#index"
	end


	namespace :admin do
		devise_for :admin_users, class_name: "Admin::AdminUser",
		:controllers => { :registrations => 'admin/admin_users/registrations',
			:sessions => 'admin/admin_users/sessions', :passwords => 'admin/admin_users/passwords' },
		path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', 
			confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' }

		root :to => "/admin/dashboard#index"
		
		resources :cie_roles do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :roles do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :cie_users do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :parameters
	end
	namespace :registry do
		devise_for :cie_users, class_name: "Registry::CieUser",
		:controllers => {
			:registrations => 'registry/cie_users/registrations',
			:sessions => 'registry/cie_users/sessions', :passwords => 'registry/cie_users/passwords'
		},
		path_names: {
			sign_in: 'login', sign_out: 'logout', password: 'secret',
			confirmation: 'verification',
			unlock: 'unblock', registration: 'register', sign_up: 'sign_up'
			}
		root :to => "/registry/dashboard#index"
		resources :events do
			collection do
				delete 'destroy_multiple'
				get 'load_therapy_room'
				get 'load_therapy_group'
			end
		end
		resources :levels do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :age_ranges do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :employees do
			collection do
				get 'load_boss'
				delete 'destroy_multiple'
			end
		end
		resources :employee_positions do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :therapy_rooms do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :therapy_types do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :patients do
			collection do
				delete 'destroy_multiple'
				get 'load_municipalities'
				get :print_invoice, defaults: { format: 'pdf' }
			end
		end
		resources :therapy_groups do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :patients, param: :id do
			get 'date_schedule'
			get 'medical_record'
			post 'medical_record'
			get :assistance
			get :print_assistance, defaults: { format: 'pdf' }
			get :print_patient, defaults: { format: 'pdf' }
			get :new_assistance_registration
			post :new_assistance_registration
		end
		resources :patients, param: :"id/:assistance_id" do
			get :edit_assistance_registration
			post :edit_assistance_registration
			delete :destroy_assistance
		end
		resources :conditions do
			collection do
				delete 'destroy_multiple'
			end
		end
		resources :date_events
		resource :reports do
			get :group_week_events
			get :employee_month_events
			get :employee_week_events
			get :patient_week_events
			get :room_week_events
			get :group_week_hours
			get :group_week_covered_hours
			get :colaborador_month_covered_hours
			get :_week_covered_hours_employee
			get :print_report, defaults: { format: 'pdf' }
		end
	end
end
