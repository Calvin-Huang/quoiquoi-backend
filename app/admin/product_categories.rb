ActiveAdmin.register ProductCategory do
  permit_params :name, :group, :order
  config.sort_order = 'order_asc'

  menu label: '商品類別管理'

  action_item do
    link_to "編輯英文內容#{'(目前編輯中)' if I18n.locale == :en}", { locale: 'en' }
  end

  action_item do
    link_to "編輯中文內容#{'(目前編輯中)' if I18n.locale == :'zh-TW'}", { locale: 'zh-TW' }
  end

  sortable

  group_map = {
    highlight: '首頁獨立項目',
    brand: '一般',
    course: '課程',
    gift_card: '禮券'
  }

  index do
    sortable_handle_column
    column '順序', :order
    id_column
    column '類別種類', :group do |resource|
      group_map[:"#{resource.group}"]
    end
    column '名稱', :name
    column '建立時間', :created_at
    actions
  end

  before_action group: :index do
    params[:group] = ProductCategory.highlight.to_a if params[:group].blank?
  end

  filter :group,
        as: :select,
        collection: ProductCategory.groups.map { |group, index|
          puts "#{group}"
          puts index
          [group_map[:"#{group}"], index]
        }
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at

  form do |f|
    f.inputs do
      # f.input :parent, label: '父類別(可留空，留空則為新的底層父類別)'
      f.input :group,
              as: :select,
              required: true,
              collection: (ProductCategory.groups.map do |group, index|
                [group_map[:"#{group}"], index]
              end),
              label: '類別種類'
      f.input :name, label: '名稱'
    end
    f.actions
  end

  controller do
    def create
      product_category = ProductCategory.create(permitted_params[:product_category])

      flash[:success] = "商品類別建立成功 - ID: #{product_category.id}"

      redirect_to admin_product_categories_path
    end
  end
end