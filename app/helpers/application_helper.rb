module ApplicationHelper
	
	def print_yes_or_no(condition)
		return 'Sí' if condition
        'No'
	end
	
	def patient_button_icon
		content_tag :span, :class => "icon_svg inline plus" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M15.573,11.624c0.568-0.478,0.947-1.219,0.947-2.019c0-1.37-1.108-2.569-2.371-2.569s-2.371,
				1.2-2.371,2.569c0,0.8,0.379,1.542,0.946,2.019c-0.253,0.089-0.496,0.2-0.728,0.332c-0.743-0.898-1.745-1.573-2.891-1.911c0.877-0.61,
				1.486-1.666,1.486-2.812c0-1.79-1.479-3.359-3.162-3.359S4.269,5.443,4.269,7.233c0,1.146,0.608,2.202,1.486,2.812c-2.454,0.725-4.252,
				2.998-4.252,5.685c0,0.218,0.178,0.396,0.395,0.396h16.203c0.218,0,0.396-0.178,0.396-0.396C18.497,13.831,17.273,12.216,15.573,
				11.624 M12.568,9.605c0-0.822,0.689-1.779,1.581-1.779s1.58,0.957,1.58,1.779s-0.688,1.779-1.58,1.779S12.568,10.427,12.568,9.605 M5.06,
				7.233c0-1.213,1.014-2.569,2.371-2.569c1.358,0,2.371,1.355,2.371,2.569S8.789,9.802,7.431,9.802C6.073,9.802,5.06,8.447,5.06,7.233 M2.309,
				15.335c0.202-2.649,2.423-4.742,5.122-4.742s4.921,2.093,5.122,4.742H2.309z M13.346,15.335c-0.067-0.997-0.382-1.928-0.882-2.732c0.502-0.271,
				1.075-0.429,1.686-0.429c1.828,0,3.338,1.385,3.535,3.161H13.346z" do
                end
			end
		end
	end
	def print_button_tag(label)
		content_container = ActiveSupport::SafeBuffer.new
		content_tag :button, :type=>"button", :class=>"btn btn-info navbar-right", 
		:"data-toggle"=>"modal", :"data-target"=>"#ModalFilterPDF" do
			content_container << content_tag(:span, :class => "icon_svg inline") do
				content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
					content_tag :path, :fill => "none", :d => "M6.506,6.98c-0.469,0-0.85,0.381-0.85,0.85s0.381,0.85,0.85,0.85s0.85-0.381,0.85-0.85S6.975,6.98,6.506,6.98z
                         M18.684,4.148h-3.398V0.75H5.656v3.398H1.691c-0.313,0-0.566,0.253-0.566,0.566V14.91c0,0.312,0.253,0.566,0.566,0.566h3.965
                        v3.398h9.629v-3.398h3.398c0.313,0,0.566-0.254,0.566-0.566V4.714C19.25,4.401,18.997,4.148,18.684,4.148z M6.789,1.882h7.363
                        v2.266H6.789V1.882z M14.152,17.742H6.789v-5.664h7.363V17.742z M18.117,13.777c0,0.312-0.254,0.566-0.566,0.566h-2.266v-3.399
                        H5.656v3.399H2.824c-0.313,0-0.566-0.254-0.566-0.566v-7.93c0-0.313,0.253-0.566,0.566-0.566h14.727
                        c0.312,0,0.566,0.253,0.566,0.566V13.777z M3.674,6.98c-0.469,0-0.85,0.381-0.85,0.85s0.381,0.85,0.85,0.85s0.85-0.381,0.85-0.85
                        S4.143,6.98,3.674,6.98z" do
	                end
				end
			end
			content_container << label
		end
	end
	def filter_button_tag
		content_container = ActiveSupport::SafeBuffer.new
		content_tag :button, :type=>"button", :class=>"btn btn-info navbar-right", 
		:"data-toggle"=>"modal", :"data-target"=>"#ModalFilter" do
			content_container << content_tag(:span, :class => "icon_svg inline") do
				content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
					content_tag :path, :fill => "none", :d => "M15.808,14.066H6.516v-1.162H5.354v1.162H4.193c-0.321,0-0.581,0.26-0.581,0.58s0.26,0.58,0.581,0.58h1.162
						v1.162h1.162v-1.162h9.292c0.32,0,0.58-0.26,0.58-0.58S16.128,14.066,15.808,14.066z M15.808,9.419h-1.742V8.258h-1.162v1.161
						h-8.71c-0.321,0-0.581,0.26-0.581,0.581c0,0.321,0.26,0.581,0.581,0.581h8.71v1.161h1.162v-1.161h1.742
						c0.32,0,0.58-0.26,0.58-0.581C16.388,9.679,16.128,9.419,15.808,9.419z M17.55,0.708H2.451c-0.962,0-1.742,0.78-1.742,1.742v15.1
						c0,0.961,0.78,1.74,1.742,1.74H17.55c0.962,0,1.742-0.779,1.742-1.74v-15.1C19.292,1.488,18.512,0.708,17.55,0.708z M18.13,17.551
						c0,0.32-0.26,0.58-0.58,0.58H2.451c-0.321,0-0.581-0.26-0.581-0.58v-15.1c0-0.321,0.26-0.581,0.581-0.581H17.55
						c0.32,0,0.58,0.26,0.58,0.581V17.551z M15.808,4.774H9.419V3.612H8.258v1.162H4.193c-0.321,0-0.581,0.26-0.581,0.581
						s0.26,0.581,0.581,0.581h4.065v1.162h1.161V5.935h6.388c0.32,0,0.58-0.26,0.58-0.581S16.128,4.774,15.808,4.774z" do
	                end
				end
			end
			content_container << "Filtrar"
		end
	end
	def check_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M17.9,4.5c-0.3-0.3-0.6-0.4-1-0.4c0,0,0,0,0,0c-0.4,0-0.8,0.2-1,0.4l-8,8L4.1,8.7c-0.6-0.6-1.5-0.6-2.1,0
                    c-0.3,0.3-0.4,0.6-0.4,1c0,0.4,0.2,0.8,0.4,1l4.8,4.8c0.3,0.3,0.6,0.4,1,0.4c0.4,0,0.8-0.2,1-0.4l9-9C18.5,6,18.5,5,17.9,4.5z" do
                end
			end
		end
	end

	def cross_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z" do
                end
			end
		end
	end

	def medical_record_resource_icon
		content_container = ActiveSupport::SafeBuffer.new
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_container << content_tag(:path, :fill => "none", :d => "M5.112,7.3c0,0.446,0.363,0.808,0.808,0.808h8.077c0.445,0,0.808-0.361,0.808-0.808c0-0.447-0.363-0.808-0.808-0.808H5.92C5.475,6.492,5.112,6.853,5.112,7.3z") do
	            end
	            content_container << content_tag(:path, :fill => "none", :d => "M5.92,5.331h4.342c0.445,0,0.808-0.361,0.808-0.808c0-0.446-0.363-0.808-0.808-0.808H5.92c-0.444,0-0.808,0.361-0.808,0.808C5.112,4.97,5.475,5.331,5.92,5.331z") do
	            end
	            content_container << content_tag(:path, :fill => "none", :d => "M13.997,9.218H5.92c-0.444,0-0.808,0.361-0.808,0.808c0,0.446,0.363,0.808,0.808,0.808h8.077c0.445,0,0.808-0.361,0.808-0.808C14.805,9.58,14.442,9.218,13.997,9.218z") do
	            end
	            content_container << content_tag(:path, :fill => "none", :d => "M13.997,11.944H5.92c-0.444,0-0.808,0.361-0.808,0.808c0,0.446,0.363,0.808,0.808,0.808h8.077c0.445,0,0.808-0.361,0.808-0.808C14.805,12.306,14.442,11.944,13.997,11.944z") do
	           	end
	            content_container << content_tag(:path, :fill => "none", :d => "M13.997,14.67H5.92c-0.444,0-0.808,0.361-0.808,0.808c0,0.447,0.363,0.808,0.808,0.808h8.077c0.445,0,0.808-0.361,0.808-0.808C14.805,15.032,14.442,14.67,13.997,14.67z") do
	            end
			end
		end
	end

	def assistance_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M9.9,3.5L0.4,1.1v15.6L9.9,19l9.5-2.4V1.1L9.9,3.5z M10.8,16.8V5.2l6.6-1.4v11.2L10.8,16.8z M9,5.2v11.7
                   	l-6.6-1.9V3.7L9,5.2z" do
                end
			end
		end
	end

	def assistance_plus_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M18.303,4.742l-1.454-1.455c-0.171-0.171-0.475-0.171-0.646,0l-3.061,
				3.064H2.019c-0.251,0-0.457,0.205-0.457,0.456v9.578c0,0.251,0.206,0.456,0.457,0.456h13.683c0.252,0,0.457-0.205,
				0.457-0.456V7.533l2.144-2.146C18.481,5.208,18.483,4.917,18.303,4.742 M15.258,15.929H2.476V7.263h9.754L9.695,
				9.792c-0.057,0.057-0.101,0.13-0.119,0.212L9.18,11.36h-3.98c-0.251,0-0.457,0.205-0.457,0.456c0,0.253,0.205,0.456,
				0.457,0.456h4.336c0.023,0,0.899,0.02,1.498-0.127c0.312-0.077,0.55-0.137,0.55-0.137c0.08-0.018,0.155-0.059,
				0.212-0.118l3.463-3.443V15.929z M11.241,11.156l-1.078,0.267l0.267-1.076l6.097-6.091l0.808,0.808L11.241,11.156z" do
                end
			end
		end
	end

	def calendar_plus_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M8.9,15.3H11v-3.2h3.1v-2H11v-3H8.9v3h-3v2h3V15.3z M18.8,0.3h-3.6v1.8c0,0.5-0.4,0.9-0.9,0.9
                    c-0.5,0-0.9-0.4-0.9-0.9V0.3H6.7v1.8C6.7,2.6,6.3,3,5.9,3C5.4,3,5,2.6,5,2.1V0.3H1.2c-0.5,0-0.9,0.4-0.9,0.9v17.6
                    c0,0.5,0.4,0.9,0.9,0.9h17.6c0.5,0,0.9-0.4,0.9-0.9V1.2C19.7,0.7,19.3,0.3,18.8,0.3z M17.9,17.9H2.1V4.5h15.9V17.9z" do
                end
			end
		end
	end
	def calendar_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M18.807,0.337h-3.616v1.808c0,0.475-0.384,0.859-0.859,0.859c-0.474,0-0.859-0.384-0.859-0.859V0.337H6.731
                    v1.808c0,0.475-0.384,0.859-0.859,0.859c-0.474,0-0.859-0.384-0.859-0.859V0.337h-3.82c-0.474,0-0.859,0.384-0.859,0.859v17.61
                    c0,0.477,0.384,0.859,0.859,0.859h17.613c0.474,0,0.859-0.382,0.859-0.859V1.195C19.665,0.721,19.281,0.337,18.807,0.337z
                     M17.948,17.946H2.052V4.528h15.896V17.946z" do
                end
			end
		end
	end
	def delete_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M9.3,1.8h1.5c0.4,0,0.7-0.3,0.7-0.7s-0.3-0.7-0.7-0.7H9.3c-0.4,0-0.7,0.3-0.7,0.7C8.6,1.5,8.9,1.8,9.3,1.8z
	                M16.5,5.5c-0.3-0.1-0.6,0-0.8,0.2c-0.2,0.2-0.4,0.4-0.4,0.7l-1.8,11H6.4l-1.8-11c0-0.3-0.2-0.5-0.4-0.7S3.7,5.4,3.4,5.5
	                c-0.3,0-0.5,0.2-0.7,0.4C2.6,6.1,2.5,6.4,2.6,6.7l1.9,11.9c0.1,0.5,0.5,0.9,1,0.9h8.9c0.5,0,0.9-0.4,1-0.9l1.9-11.9
	                c0-0.3,0-0.6-0.2-0.8C17,5.7,16.8,5.5,16.5,5.5z M3.4,4.5h13.2c0.6,0,1-0.5,1-1s-0.5-1-1-1H3.4c-0.6,0-1,0.5-1,1S2.8,4.5,3.4,4.5z" do
                end
			end
		end
	end
	def clean_filter_icon
		content_container = ActiveSupport::SafeBuffer.new
		content_tag :button, :type=>"button", :class=>"btn btn-info navbar-right" do
			content_container << content_tag(:span, :class => "icon_svg inline") do
				content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
					content_tag :path, :fill => "none", :d => "M3.24,7.51c-0.146,0.142-0.146,0.381,0,0.523l5.199,5.193c0.234,0.238,0.633,0.064,0.633-0.262v-2.634c0.105-0.007,0.212-0.011,0.321-0.011c2.373,0,4.302,1.91,4.302,4.258c0,0.957-0.33,1.809-1.008,2.602c-0.259,0.307,0.084,0.762,0.451,0.572c2.336-1.195,3.73-3.408,3.73-5.924c0-3.741-3.103-6.783-6.916-6.783c-0.307,0-0.615,0.028-0.881,0.063V2.575c0-0.327-0.398-0.5-0.633-0.261L3.24,7.51 M4.027,7.771l4.301-4.3v2.073c0,0.232,0.21,0.409,0.441,0.366c0.298-0.056,0.746-0.123,1.184-0.123c3.402,0,6.172,2.709,6.172,6.041c0,1.695-0.718,3.24-1.979,4.352c0.193-0.51,0.293-1.045,0.293-1.602c0-2.76-2.266-5-5.046-5c-0.256,0-0.528,0.018-0.747,0.05C8.465,9.653,8.328,9.81,8.328,9.995v2.074L4.027,7.771z" do
	                end
				end
			end
			content_container << "Quitar filtros"
		end
		# content_tag :span, :class => "icon_svg inline" do
		# 	content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
		# 		content_tag :path, :fill => "none", :d => "M9.3,1.8h1.5c0.4,0,0.7-0.3,0.7-0.7s-0.3-0.7-0.7-0.7H9.3c-0.4,0-0.7,0.3-0.7,0.7C8.6,1.5,8.9,1.8,9.3,1.8z
		# 		M16.5,5.5c-0.3-0.1-0.6,0-0.8,0.2c-0.2,0.2-0.4,0.4-0.4,0.7l-1.8,11H6.4l-1.8-11c0-0.3-0.2-0.5-0.4-0.7S3.7,5.4,3.4,5.5
		# 		c-0.3,0-0.5,0.2-0.7,0.4C2.6,6.1,2.5,6.4,2.6,6.7l1.9,11.9c0.1,0.5,0.5,0.9,1,0.9h8.9c0.5,0,0.9-0.4,1-0.9l1.9-11.9
		# 		c0-0.3,0-0.6-0.2-0.8C17,5.7,16.8,5.5,16.5,5.5z M3.4,4.5h13.2c0.6,0,1-0.5,1-1s-0.5-1-1-1H3.4c-0.6,0-1,0.5-1,1S2.8,4.5,3.4,4.5z" do
        #         end
		# 	end
		# end
	end
	def print_info_icon(type)
		content_container = ActiveSupport::SafeBuffer.new
		content_tag :button, :type=>"button", :class=>"btn btn-info navbar-right" do
			content_container << content_tag(:span, :class => "icon_svg inline") do
				content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 32 32" do
					content_tag :path, :fill => "none", :d => "M27 0h-24c-1.65 0-3 1.35-3 3v26c0 1.65 1.35 3 3 3h24c1.65 0 3-1.35 3-3v-26c0-1.65-1.35-3-3-3zM26 28h-22v-24h22v24zM8 18h14v2h-14zM8 22h14v2h-14zM10 9c0-1.657 1.343-3 3-3s3 1.343 3 3c0 1.657-1.343 3-3 3s-3-1.343-3-3zM15 12h-4c-1.65 0-3 0.9-3 2v2h10v-2c0-1.1-1.35-2-3-2z" do
	                end
				end
			end
			if type == :pdf
				content_container << "Imprimir información"
			elsif type == :excel
				content_container << "Imprimir información en Excel"
			end
		end
	end
	def edit_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M19.404,6.65l-5.998-5.996c-0.292-0.292-0.765-0.292-1.056,0l-2.22,2.22l-8.311,
					8.313l-0.003,0.001v0.003l-0.161,0.161c-0.114,0.112-0.187,0.258-0.21,0.417l-1.059,7.051c-0.035,0.233,0.044,0.47,0.21,0.639c0.143,
					0.14,0.333,0.219,0.528,0.219c0.038,0,0.073-0.003,0.111-0.009l7.054-1.055c0.158-0.025,0.306-0.098,0.417-0.211l8.478-8.476l2.22-2.22C19.695,
					7.414,19.695,6.941,19.404,6.65z M8.341,16.656l-0.989-0.99l7.258-7.258l0.989,0.99L8.341,16.656z M2.332,15.919l0.411-2.748l4.143,4.143l-2.748,
					0.41L2.332,15.919z M13.554,7.351L6.296,14.61l-0.849-0.848l7.259-7.258l0.423,0.424L13.554,7.351zM10.658,4.457l0.992,0.99l-7.259,7.258L3.4,11.715L10.658,
					4.457z M16.656,8.342l-1.517-1.517V6.823h-0.003l-0.951-0.951l-2.471-2.471l1.164-1.164l4.942,4.94L16.656,8.342z" do
                end
			end
		end
	end
	def show_resource_icon
		content_tag :span, :class => "icon_svg inline" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M18.6,17.2l-2.7-2.7c1.2-1.5,1.9-3.4,1.9-5.3c0-4.6-3.8-8.4-8.4-8.4C4.8,0.9,1,4.6,1,9.2c0,4.6,3.8,8.4,8.4,8.4
                    c1.7,0,3.5-0.6,4.9-1.6l2.8,2.8c0.2,0.2,0.5,0.3,0.8,0.3c0.3,0,0.6-0.1,0.8-0.3C19.1,18.4,19.1,17.7,18.6,17.2z M9.4,15.4
                    c-3.4,0-6.1-2.8-6.1-6.1c0-3.4,2.8-6.1,6.1-6.1c3.4,0,6.2,2.8,6.2,6.1C15.6,12.6,12.8,15.4,9.4,15.4z" do
                end
			end
		end
	end
	def new_resource_icon
		content_tag :span, :class => "icon_svg inline plus" do
			content_tag :svg, :class=> "svg-icon", :viewBox => "0 0 20 20" do
				content_tag :path, :fill => "none", :d => "M13.68,9.448h-3.128V6.319c0-0.304-0.248-0.551-0.552-0.551S9.448,6.015,9.448,6.319v3.129H6.319
                    c-0.304,0-0.551,0.247-0.551,0.551s0.247,0.551,0.551,0.551h3.129v3.129c0,0.305,0.248,0.551,0.552,0.551s0.552-0.246,0.552-0.551
                    v-3.129h3.128c0.305,0,0.552-0.247,0.552-0.551S13.984,9.448,13.68,9.448z M10,0.968c-4.987,0-9.031,4.043-9.031,9.031
                    c0,4.989,4.044,9.032,9.031,9.032c4.988,0,9.031-4.043,9.031-9.032C19.031,5.012,14.988,0.968,10,0.968z M10,17.902
                    c-4.364,0-7.902-3.539-7.902-7.903c0-4.365,3.538-7.902,7.902-7.902S17.902,5.635,17.902,10C17.902,14.363,14.364,17.902,10,17.902
                    z" do
                end
			end
		end
	end
	def checked_permission(object, resource, action) 
		if !object.new_record?
			record = Admin::CieRolePermission.where(:admin_cie_role => object.id, :admin_resource => resource.id, :admin_action => action.id)
			if record.present?
				check_box_tag "admin_cie_role[admin_cie_role_permissions_attributes][#{@index}][permission_validator]", 'yes', true, :class=>"flat"
			else
				check_box_tag "admin_cie_role[admin_cie_role_permissions_attributes][#{@index}][permission_validator]", 'yes', false, :class=>"flat"
			end
		else
			check_box_tag "admin_cie_role[admin_cie_role_permissions_attributes][#{@index}][permission_validator]", 'yes', false, :class=>"flat"
		end
	end

	def current_page(controller_name)
		if (controller.class==controller_name)
			"current-page"
		end
	end

	def footer_menu
		items = [left_link, middle_left_link, middle_right_link, right_link]
		content_tag :div, :class => "sidebar-footer hidden-small" do
			items.collect { |item| concat item}
		end
	end
	def left_link
		link_to(content_tag(:span, nil, :class=>"glyphicon", :"aria-hidden"=>"true"), 
			nil, :"data-toggle"=>"", :"data-placement"=>"", :title=>'')
	end
	def middle_left_link
		left_link
	end
	def middle_right_link
		left_link
	end
	def right_link
		content_container = ActiveSupport::SafeBuffer.new
		content_container << content_tag(:span,nil,:class=>"icon exit_icon")
		content_container << content_tag(:span,"Salir",:class=>"exit_nav")

		link_to(content_container, 
			end_session_path, :class=>"link", :"data-toggle"=>"tooltip", :"data-placement"=>"top", :title=>'Salir', :method => :delete )
	end

	def top_nav_menu
		content_tag :div, :class => "top_nav" do
			content_tag :div, :class => "nav_menu" do
				content_tag :nav, :role => "navigation" do
					bar_link = content_tag :div, :class=>"nav toggle" do
						content_tag :a, :id => "menu_toggle" do
							content_tag(:i,nil,:class=>"fa fa-bars")
						end
					end
					menu_container = content_tag :ul, :class=> "nav navbar-nav navbar-right" do
						concat alerts_menu
						concat user_menu
					end
					concat bar_link
					concat menu_container
				end
			end
		end
	end

	def user_menu
		content_tag :li do
			content_container = ActiveSupport::SafeBuffer.new
			internal_content_container = ActiveSupport::SafeBuffer.new
			content_container << link_to("#", :class=>"user-profile dropdown-toggle", :"data-toggle"=>"dropdown", :"aria-expanded"=>"false") do
				concat image_tag(current_cie_user.image_source("avatar"), "aria-hidden"=>"false")
				concat " " + current_cie_user.name.to_s + " "
				concat content_tag(:span, nil, :class=>"fa fa-angle-down")
			end

			content_container << content_tag(:ul, :class=>"dropdown-menu dropdown-usermenu pull-right") do
				internal_content_container << content_tag(:li) do
					concat link_to("Perfil", edit_cie_user_path)
				end
				#internal_content_container << content_tag(:li) do
				#	link_to("Settings", "#")
				#end
				#internal_content_container << content_tag(:li) do
				#	link_to("Help", "#")
				#end
				internal_content_container << content_tag(:li) do
					link_to(content_tag(:i, nil, :class=>"fa fa-sign-out pull-right") + " Salir", 
						end_session_path, :method => :delete)
				end
				internal_content_container
			end
			content_container
		end
	end

	def alerts_menu
		content_container = ActiveSupport::SafeBuffer.new
		internal_content_container = ActiveSupport::SafeBuffer.new
		sub_internal_content_container = ActiveSupport::SafeBuffer.new
		events = Registry::DateEvent.where(start_time: Date.today..Date.tomorrow+1.day)
		content_tag(:li, :role, :class=>"dropdown") do
			content_container << link_to("#", :class=>"dropdown-toggle info-number", 
				:"data-toggle"=>"dropdown", 
				:onclick=>"javascript:unhide('notification_sidebar');", 
				:"aria-expanded"=>"false",
				href: "http://cie.bi.com.ni/registry#") do
				concat content_tag(:i, nil, :class=>"fa fa-envelope-o")
				concat content_tag(:span, events.count, :class=>"badge bg-green")
			end
			content_container << content_tag(:ul, :class=>"dropdown-menu list-unstyled msg_list", :role=>"menu") do

				events.order(:start_time).each do |event|
					internal_content_container << content_tag(:li) do	
						content_tag :a, :href=>registry_patient_date_schedule_path(event.registry_patient_id) do
							content_tag(:span, :class=>"image") do
								sub_internal_content_container << content_tag(:img, nil, 
									:src=>"/assets/CIE_logo.png", :alt=>"Profile Image")
								sub_internal_content_container << content_tag(:span) do
									concat content_tag(:span, event.date_event_type)
									concat content_tag(:span, distance_of_time_in_words(DateTime.now.to_i - event.start_time.to_i), 
										:class=>"time")
									concat content_tag(:br)
									concat content_tag(:span, event.registry_patient.display_name + " - " + event.display_name )
									
								end
								sub_internal_content_container << content_tag(:span, 
									event.description, :class=>"message")
								sub_internal_content_container
							end
						end
					end
					sub_internal_content_container = ActiveSupport::SafeBuffer.new
				end
				internal_content_container << content_tag(:li) do
					content_tag(:div, :class=>"text-center") do
						link_to registry_root_path do
							concat content_tag(:strong, "Ver Todos ")
							concat content_tag(:i, nil, :class=> "fa fa-angle-right")
						end
					end
				end
				internal_content_container
			end
			content_container
		end
	end
	def todays_date
		Registry::DateEvent.where("start_time between ? and ? ",Date.today.at_beginning_of_day,Date.today.at_end_of_day).count
	end
	def month_date
		Registry::DateEvent.where("start_time between ? and ? ",Date.today.at_beginning_of_month,Date.today.at_end_of_month).count
	end
	def week_date
		Registry::DateEvent.where("start_time between ? and ? ",Date.today.at_beginning_of_week,Date.today.at_end_of_week).count
	end
end
