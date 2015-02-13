class User < ActiveRecord::Base
  has_many :transactions, foreign_key: 'recipient_id', dependant: :delete_all

  phony_normalize :mobile, :default_country_code => 'FR'

  validates :email, :presence => true, :email => true  
  validates :mobile, presence: true, :phony_plausible => true
  validates :firstname, presence: true
  validates :lastname, presence: true

  def hash_id
    User.hash_id_instance.encode(id)
  end

  scope :with_hash_id, -> (value) { where(id: User.decode_hash_id(value)) }

  def self.ransackable_scopes(auth_object = nil)
    [:with_hash_id]
  end

  def self.decode_hash_id(value)
    hash_id_instance.decode(value)
  end

  def self.hash_id_instance 
    Hashids.new(Rails.configuration.hashid.salt, Rails.configuration.hashid.minimum_length, Rails.configuration.hashid.authorized)
  end

  def credit
    transactions.sum(:amount)
  end
end
