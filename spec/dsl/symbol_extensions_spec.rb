require 'spec_helper'

describe 'Eel Symbol extensions' do
  context 'Symbol' do

    unary_predicates = %w[desc asc].map(&:to_sym)
    binary_predicates = %w[eq not_eq gt gteq lt lteq in not_in].map(&:to_sym)
    predicates = unary_predicates + binary_predicates

    subject { :some_symbol }

    context 'Arel::Attribute conversion methods' do
      it { should respond_to(:of) }
      it { should respond_to(:attr) }
    end

    context 'Arel::Attribute predicates' do
      predicates.each do |predicate|
        it { should respond_to(predicate) }
      end

      it 'should return Arel::Nodes::Node on predicates methods' do
        binary_predicates.each do |predicate|
          :test_symbol.send(predicate, 1).should be_kind_of(Arel::Nodes::Node)
        end
        unary_predicates.each do |predicate|
          :test_symbol.send(predicate).should be_kind_of(Arel::Nodes::Node)
        end
      end
    end

    context 'dynamic methods' do
      it 'should define predicate methods after first call' do
        binary_predicates.each do |predicate|
          :test_symbol.send(predicate, 1)
          Symbol.instance_methods.should include(predicate)
        end
        unary_predicates.each do |predicate|
          :test_symbol.send(predicate)
          Symbol.instance_methods.should include(predicate)
        end
      end
    end

  end
end