require 'spec_helper'

describe 'Eel produced sql' do
  context 'simple ordering' do
    it 'should produce correct desc order statements' do
      Post.order(:id.desc).to_sql.should eq(Post.order('"posts"."id" DESC').to_sql)
    end
    it 'should produce correct asc order statements' do
      Post.order(:id.asc).to_sql.should eq(Post.order('"posts"."id" ASC').to_sql)
    end
    it 'should produce correct desc reorder statements' do
      Post.order(:created_at).reorder(:id.desc).to_sql.should eq(Post.order(:created_at).reorder('"posts"."id" DESC').to_sql)
    end
    it 'should produce correct asc reorder statements' do
      Post.order(:created_at).reorder(:id.asc).to_sql.should eq(Post.order(:created_at).reorder('"posts"."id" ASC').to_sql)
    end
  end

  context 'combined ordering' do
    it 'should produce correct combined order statements' do
      Post.order(:id.desc, :created_at.asc).to_sql.
          should eq(Post.order('"posts"."id" DESC, "posts"."created_at" ASC').to_sql)
    end
    it 'should produce correct combined reorder statements' do
      Post.order(:created_at).reorder(:id.desc, :updated_at.asc).to_sql.
        should eq(Post.order(:created_at).reorder('"posts"."id" DESC, "posts"."updated_at" ASC').to_sql)
    end
  end
end