require 'mandrill'

class User < ActiveRecord::Base
  has_many :transactions, foreign_key: 'recipient_id', dependent: :delete_all

  phony_normalize :mobile, :default_country_code => 'FR'

  validates :email, :presence => true, :email => true  
  validates :mobile, presence: true, :phony_plausible => true
  validates :firstname, presence: true
  validates :lastname, presence: true


  after_create :send_notification

  def send_notification 
    begin
      mandrill = Mandrill::API.new '94PHEwv-VOZa0gRmnEYFkA'
      message = {
         "text"=>"Un nouvel ambassadeur a été créé avec le code parrain: #{hash_id}",
         "to"=>
            [{"type"=>"to",
                "email"=>"marketing@mobileangelo.fr",
                "name"=>"Mobile Angelo"}],
         "from_name"=>"Back office ambassadeur",
         "from_email"=>"no-reply@mobileangelo.fr",
         "subject"=>"Nouvel ambassadeur"
       }

      async = false
      result = mandrill.messages.send message, async
        
    rescue Mandrill::Error => e
        # Mandrill errors are thrown as exceptions
        puts "A mandrill error occurred: #{e.class} - #{e.message}"
        # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'    
        raise
    end
  end

  def as_json(options={})
    super(:only => [:email, :mobile, :firstname, :lastname], :methods => [:hash_id, :credit])
  end

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
