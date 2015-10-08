ActiveAdmin.register User do
  permit_params :email, :preferred_working_hours_per_day, :password

  index do
    id_column
    column :email
    column :preferred_working_hours_per_day
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :preferred_working_hours_per_day
      f.input :password
    end
    actions
  end

end
