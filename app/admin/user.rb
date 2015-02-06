ActiveAdmin.register User do

  index do
    selectable_column

    column :firstname
    column :lastname
    column :email
    column :mobile do |user|
      user.mobile.phony_formatted
    end
    column "Sponsor Code", :hash_id
    column "Total credit" do |user|
      number_to_currency(user.credit, locale: :fr)
    end
    
    actions
  end

  sidebar "Transactions", only: [:show, :edit] do
    ul do
      li link_to "Transactions",    admin_user_transactions_path(user)
    end
  end

  show :title => proc{|user| user.mobile.phony_formatted } do |user|
    panel("User details") do
      attributes_table_for user do
        row :firstname
        row :lastname
        row :email
        row :mobile do |user|
          user.mobile.phony_formatted
        end
        row "Sponsor Code" do |user|
          user.hash_id
        end
        row "Total credit" do |user|
          number_to_currency(user.credit, locale: :fr)
        end
      end
    end 
=begin
    panel("Transactions") do
      table_for(user.transactions) do   
        column :amount          
        column :sender_name
        column :sender_mail
        column :sender_mobile
      end
    end
=end

  end

  form do |f|
    f.inputs "User" do
      f.input :firstname
      f.input :lastname
      f.input :mobile, :input_html => { :value => f.object.mobile.phony_formatted }
      f.input :email
    end
    f.actions
  end

  permit_params do
    [:firstname, :lastname, :mobile, :email]
  end

  preserve_default_filters!
  filter :with_hash_id, as: :string, label: 'Sponsor code'
end
