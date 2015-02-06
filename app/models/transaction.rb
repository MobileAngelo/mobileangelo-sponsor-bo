class Transaction < ActiveRecord::Base
  belongs_to :recipient, class_name: 'User'

  phony_normalize :sender_mobile, :default_country_code => 'FR'

  validates :sender_mail, :presence => true, :email => true  
  validates :sender_mobile, presence: true, :phony_plausible => true
  validates :amount, presence: true, numericality: true
end
