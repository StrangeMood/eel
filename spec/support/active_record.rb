ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :todo_items do |t|
  t.string :name, null: false
  t.integer :score_points, null: false, default: 0
  t.integer :parent_id
  t.date :due_date
  t.timestamps
end

class TodoItem < ActiveRecord::Base
  validates :name, presence: true
  validates :score_points, presence: true

  belongs_to :parent, class_name: 'TodoItem'
  has_many :sub_tasks, class_name: 'TodoItem', foreign_key: :parent_id, inverse_of: :parent
end
