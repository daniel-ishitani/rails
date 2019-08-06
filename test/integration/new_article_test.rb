require 'test_helper'

class NewArticleTest < ActionDispatch::IntegrationTest
    def setup
        @user = User.create(username: 'dan', email: 'dan@example.com', password: 'pass', admin: true)
        sign_in_as(@user, 'pass')
    end

    test 'create article' do
        get new_article_path
        assert_template 'articles/new'
        assert_difference 'Article.count', 1 do
            post articles_path, params: { article: {title: 'title', description: 'description', category_ids: []}}
            follow_redirect!
        end
        assert_template 'articles/show'
        assert_match 'title', response.body
    end

    test 'create article fails' do
        get new_article_path
        assert_template 'articles/new'
        assert_no_difference 'Article.count' do
            post articles_path, params: { article: {title: '', description: 'description', category_ids: []}}
        end
        assert_template 'articles/new'
    end
end