ActiveAdmin.register ProductCategory do
  menu label: '商品類別管理'

  index do
    selectale_column
    id_column
    # column :email
    # column '最近登入時間', :current_sign_in_at
    # column '登入次數', :sign_in_count
    # column '建立時間', :created_at
    actions
  end

  # filter :email
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at

  form do |f|
    f.inputs do
      f.input :email
    end
    f.actions
  end
end