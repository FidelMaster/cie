# == Schema Information
#
# Table name: registry_treatment_requirements
#
#  id                                 :integer          not null, primary key
#  registry_patient_id                :integer
#  entrance_letter                    :boolean
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  epicrisis                          :boolean
#  birth_certificate                  :boolean
#  beneficiary_child_license          :boolean
#  active_secured_parent_id_card      :boolean
#  active_secured_parent_license      :boolean
#  payment_receipt_inss               :boolean
#  beneficiary_social_security_number :string
#  insured_tutor_number               :string
#  other_studies                      :string
#  informed_consent                   :boolean          default(FALSE)
#  permission_to_take_photos          :boolean          default(FALSE)
#  school_insurance                   :boolean          default(FALSE)
#

class Registry::TreatmentRequirement < ApplicationRecord
  belongs_to :registry_patient, :class_name => "Registry::Patient", :inverse_of => :registry_treatment_requirement
  def self.security_name
    "Requerimientos"
  end
  def self.treatment_hash
  	{:entrance_letter => "Carta de solicitud", 
  		:epicrisis => "Epicrisis", 
  		:birth_certificate => "Partida de nacimiento", 
  		:beneficiary_child_license => "Carnet de beneficiario", 
  		:active_secured_parent_id_card => "Cedula de mamá o papá", 
  		:active_secured_parent_license => "Carnet de asegurado de mamá o papá", 
  		:payment_receipt_inss => "Comprobante de pago y derecho (Colilla del INSS)",
      :beneficiary_social_security_number => "Número INSS del beneficiario"
  	}
  end

end
