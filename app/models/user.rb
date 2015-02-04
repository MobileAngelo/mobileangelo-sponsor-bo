class User < ActiveRecord::Base
  phony_normalize :mobile, :default_country_code => 'FR'

  validates :email, :presence => true, :email => true  
  validates :mobile, presence: true, :phony_plausible => true
  validates :firstname, presence: true
  validates :lastname, presence: true
end
