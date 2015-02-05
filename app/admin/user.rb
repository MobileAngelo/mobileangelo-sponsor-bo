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
    
    actions
  end

  show :title => proc{|user| user.mobile.phony_formatted } do 
    attributes_table do
      row :firstname
      row :lastname
      row :email
      row :mobile do |user|
        user.mobile.phony_formatted
      end
      row "Sponsor Code" do |user|
        user.hash_id
      end
    end
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
