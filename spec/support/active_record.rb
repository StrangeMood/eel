ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :users do |t|
  t.string :name
  t.string :email
  t.timestamps
end

ActiveRecord::Migration.create_table :posts do |t|
  t.string :title
  t.text :text
  t.integer :author_id
  t.date :post_date
  t.timestamps
end

ActiveRecord::Migration.create_table :comments do |t|
  t.text :text
  t.integer :commenter_id
  t.string :parent_type
  t.integer :parent_id
  t.date :comment_date
  t.timestamps
end

class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :comments, as: :parent
end

class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: 'User'
  belongs_to :parent, polymorphic: true
  has_many :comments, as: :parent
end