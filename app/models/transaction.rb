class Transaction < ActiveRecord::Base
  belongs_to :recipient, class_name: 'User'
end
