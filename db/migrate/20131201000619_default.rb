class Default < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true

    create_table :events do |t|
      t.string    :title
      t.string    :area
      t.string    :subtitle
      t.datetime  :start_at
      t.datetime  :end_at
      t.string    :image
      t.text      :body
      t.boolean   :active
      t.boolean   :highlight
      t.timestamps
    end

    create_table    :gallery_mappings do |t|
      t.references  :owner, polymorphic: true
      t.references  :gallery
    end

    create_table    :galleries do |t|
      t.string      :title
      t.string      :subtitle
      t.text      :description
      t.string      :category
      t.timestamps
    end

    create_table    :gallery_images do |t|
      t.string      :image
      t.references  :gallery
      t.timestamps
    end

    # create_table :pages do |t|
    #   t.string :title
    #   t.boolean :landgasthaus
    #   t.boolean :catering
    #   t.text :html
    #   t.timestamps
    # end

    # create_table :page_elements do |t|
    #   t.boolean :split
    #   t.integer :internal_id
    #   t.string :type #STI
    #   t.references :page
    #   t.references :row
    #   t.references :cell
    #   t.text :images
    #   t.integer :side
    #   t.string :backgroundcolor
    #   t.float :height
    #   t.references :gallery
    #   t.references :event
    #   t.string :image
    #   t.text :text
    # end

    create_table :statistics do |t|
      t.integer :count_requests
    end

    create_table :files do |t|
      t.string 'description'
      t.string 'slug'
      t.string 'file'
      t.timestamps
    end

    create_table :pages do |t|
      t.string 'name'
      t.string 'slug'
      t.string 'url_path'
      t.integer 'position'
      t.boolean 'menu_only'
      t.string 'type'
      t.string 'ancestry'
      t.string 'description'
      t.string 'menu_title'
      t.boolean 'published', default: false
      t.boolean 'hidden', default: false
      t.string 'layout', default: "application"
      t.string 'template', default: "default"
      t.string 'linked_to'
      t.timestamps
    end
    add_index :pages, :ancestry
    add_index :pages, :published
    add_index :pages, :hidden

    create_table :paragraphs do |t|
      t.string 'area_name'
      t.integer 'position'
      t.string 'type'
      t.text 'data'
      t.text 'unpublished_data'
      t.references 'page'
      t.timestamps
    end

    create_table :image_assets do |t|
      t.string 'file'
      t.string 'file_unpublished'
      t.string 'type'
      t.timestamps
    end
  end
end
