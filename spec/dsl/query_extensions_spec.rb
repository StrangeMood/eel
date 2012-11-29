require 'spec_helper'

describe 'Eel Query extensions' do

  module QueryMethodsDumper
    def where *args
      build_where(*args)
    end

    def table
      Post.arel_table
    end
  end

  class DemoClass
    extend QueryMethodsDumper
    extend Eel::ActiveRecord::QueryExtensions
  end

  subject { DemoClass }

  context 'Plain objects' do
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

end