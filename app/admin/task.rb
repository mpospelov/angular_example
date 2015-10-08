ActiveAdmin.register Task do
  permit_params :description, :date, :duration, :user_id

  controller do
    def scoped_collection
      super.includes(:user)
    end
  end

  index do
    id_column
    column :user do |t|
      link_to t.user.email, admin_user_path(t.user)
    end
    column :description
    column :date
    column :duration
    actions
  end

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.pluck(:email, :id)
      f.input :description
      f.input :date
      f.input :duration
    end
    actions
  end
end
