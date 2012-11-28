require 'spec_helper'

describe 'Eel query dsl' do
  context 'Simple filtering' do
    before do
      3.times do |index|
        create(:todo_item, score_points: index + 1, due_date: Date.current + index.days)
      end
    end

    context 'greater than' do
      subject { TodoItem.where(:score_points.gt 2) }
      it { should have(1).item }
    end

    context 'less than' do
      subject { TodoItem.where(:score_points.lt 3) }
      it { should have(2).items }
    end

    context 'combine comparsions' do
      subject { TodoItem.where(:score_points.gt(1), :due_date.lt(2.days.since.to_date)) }

      it { should have(1).item }
      its('first.score_points') { should be(2) }
    end

  end

  #context 'Filtering with joins' do
  #  before do
  #    head = create(:todo_item, score_points: 10, due_date: Date.current)
  #    3.times do |index|
  #      create(:todo_item, parent: head, score_points: index + 1, due_date: Date.current + index.days)
  #    end
  #  end
  #
  #  context 'greater than' do
  #    subject { TodoItem.joins(:sub_tasks).where(:sub_tasks => {:id => 12}) }
  #    it { should have(1).item }
  #    its('first.parent') { should_not be(nil) }
  #  end
  #end
end