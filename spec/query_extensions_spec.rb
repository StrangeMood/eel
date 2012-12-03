require 'spec_helper'

describe 'Eel Query extensions' do

  module QueryMethodsDumper
    def method_missing name, *args
      args
    end

    def where *args
      build_where(*args)
    end
  end

  class DemoClass
    extend QueryMethodsDumper
    extend Eel::ActiveRecord::QueryExtensions
  end

  subject { DemoClass }

  context 'Plain objects with order/reorder' do
    it 'should not do anything with plain symbol' do
      [:order, :reorder].each do |method|
        subject.should_receive(:method_missing).with(method, :id)
        subject.send(method, :id)
      end
    end
    it 'should not do anything with plain string' do
      [:order, :reorder].each do |method|
        subject.should_receive(:method_missing).with(method, 'id DESC')
        subject.send(method, 'id DESC')
      end
    end
    it 'should not do anything with several plain objects' do
      [:order, :reorder].each do |method|
        subject.should_receive(:method_missing).with(method, :created_at, 'id DESC')
        subject.send(method, :created_at, 'id DESC')
      end
    end
    it 'should not do anything with array of plain objects' do
      [:order, :reorder].each do |method|
        subject.should_receive(:method_missing).with(method, :created_at, 'id DESC')
        subject.send(method, [:created_at, 'id DESC'])
      end
    end
  end

  context 'Plain objects with where' do
    it 'should ignore regular AR requests' do
      subject.should_receive(:method_missing).with(:build_where, {:id => 12}, [])
      subject.where(:id => 12)

      subject.should_receive(:method_missing).with(:build_where, 'id = 12', [])
      subject.where('id = 12')
    end
  end

  context 'Assigning relation' do

    QueryMethodsDumper.class_eval do
      def table
        Post.arel_table
      end
    end

    context 'left auto bind' do
      subject { DemoClass.where(:id.gt 12) }
      it { should be_kind_of Array }
      its('first.left.relation') { should be Post.arel_table }
    end

    context 'left auto bind, right auto bind' do
      subject { DemoClass.where(:id.gt :created_at.attr) }
      it { should be_kind_of Array }
      its('first.left.relation') { should be Post.arel_table }
      its('first.right.relation') { should be Post.arel_table }
    end

    context 'left auto bind and right manual Class bind' do
      subject { DemoClass.where(:id.gt :created_at.of(User)) }
      it { should be_kind_of Array }
      its('first.left.relation') { should be Post.arel_table }
      its('first.right.relation') { should be User.arel_table }
    end

    context 'left manual bind and right manual Class bind' do
      subject { DemoClass.where(:id.of(Post).gt :created_at.of(User)) }
      it { should be_kind_of Array }
      its('first.left.relation') { should be Post.arel_table }
      its('first.right.relation') { should be User.arel_table }
    end

    context 'auto bind unary nodes' do
      subject { DemoClass.order(:id.desc) }

      it { should be_kind_of Array }
      its('first.expr.relation') { should be Post.arel_table }
    end

    context 'manual bind Class unary nodes' do
      subject { DemoClass.order(:id.of(User).desc) }

      it { should be_kind_of Array }
      its('first.expr.relation') { should be User.arel_table }
    end

    context 'manual bind Symbol unary nodes' do
      subject { DemoClass.order(:id.of(:posts).desc) }

      it { should be_kind_of Array }
      its('first.expr.relation.name') { should eq Post.arel_table.name }
    end

    context 'manual bind Symbol binary nodes' do
      subject { DemoClass.where(:id.of(:users).gt :created_at.of(:posts)) }
      it { should be_kind_of Array }
      its('first.left.relation.name') { should eq User.arel_table.name }
      its('first.right.relation.name') { should eq Post.arel_table.name }
    end

  end

end