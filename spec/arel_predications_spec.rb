require 'spec_helper'
require 'arel_predications'

describe 'Arel predications' do
  context 'Nodes creation correctness' do

    it 'should produce correct between node' do
      :id.of('posts').between(1,2).to_sql.
          should eq('"posts"."id" BETWEEN 1 AND 2')
    end

    it 'should produce correct is_null node' do
      :id.of('posts').is_null.to_sql.
          should eq('"posts"."id" IS NULL')
    end

    it 'should produce correct is_not_null node' do
      :id.of('posts').is_not_null.to_sql.
          should eq('"posts"."id" IS NOT NULL')
    end

  end

end