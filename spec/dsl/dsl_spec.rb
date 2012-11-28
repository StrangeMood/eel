require 'spec_helper'

describe 'Eel query dsl' do
  context 'Simple filtering' do
    before do
      3.times do |index|
        create(:post, author_id: index + 1, post_date: Date.current + index.days)
      end
    end

    context 'greater than' do
      subject { Post.where(:author_id.gt 2) }
      it { should have(1).item }
    end

    context 'less than' do
      subject { Post.where(:author_id.lt 3) }
      it { should have(2).items }
    end

    context 'combine comparsions' do
      subject { Post.where(:author_id.gt(1), :post_date.lt(2.days.since.to_date)) }

      it { should have(1).item }
      its('first.author_id') { should be(2) }
    end

  end

end