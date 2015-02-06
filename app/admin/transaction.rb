ActiveAdmin.register Transaction do
  belongs_to :user

  index do
    selectable_column

    column :amount do |transaction|
      number_to_currency(transaction.amount, locale: :fr)
    end
    column :sender_name
    column :sender_mail
    column :sender_mobile do |transaction|
      transaction.sender_mobile.phony_formatted
    end
    #column "Sponsor Code", :hash_id
    
    actions
  end

  form do |f|
    inputs 'Details' do
      input :recipient_id, as: :hidden
      input :amount
      input :sender_name
      input :sender_mobile
      input :sender_mail
    end
    actions
  end

  permit_params do
    [:recipient_id, :amount, :sender_name, :sender_mail, :sender_mobile]
  end  

  filter :amount
  filter :sender_name
  filter :sender_mail
  filter :sender_mobile
  filter :created_at
end
