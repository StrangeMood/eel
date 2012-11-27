FactoryGirl.define do
  sequence(:name_of_todo) { |n| "Task numba #{n}" }

  factory :todo_item do
    name { generate :name_of_todo }
    score_points 0
    due_date { Date.current }
  end
end