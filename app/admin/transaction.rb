ActiveAdmin.register Transaction do
  belongs_to :user

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
end
