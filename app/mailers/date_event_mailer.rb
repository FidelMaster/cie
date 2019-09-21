class DateEventMailer < ActionMailer::Base
  default from: 'no-reply@cie.com'
  layout 'mailer'


  	def self.date_sender(personList, date_event)
		personList.each do |person|
			if person.email.present? && DateEventMailer.is_a_valid_email?(person.email)
				date_mail(person, date_event).deliver!
			end
		end
	end

	def date_mail(person, date_event, opts={})
		@person = person
		@date_event = date_event
		mail(to: @person.email, subject: 'Nueva programación de Cita o Evaluación')
	end
	
	def self.is_a_valid_email?(email)
		puts ">>>>> #{email}"
		special = "?<>',?[]}{=-)(*&^%$#`~{}"
		regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
		if email.count("@") != 1 then
			puts ">>>>> #{email} format invalid "
			return false
		elsif email =~ regex
			puts ">>>>> #{email} format invalid "
			return false
		elsif email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i then
			puts ">>>>> #{email} valid "
			return true
		else
			return false
		end
	end
end
