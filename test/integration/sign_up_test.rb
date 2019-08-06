require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

    test 'user sign up' do
        get signup_path
        assert_template 'users/new'
        assert_difference 'User.count', 1 do
            post users_path, params: { user: {username: 'dan', email: 'dan@gmail.com', password: '123'}}
            follow_redirect!
        end
        assert_template 'users/show'
        assert_match 'dan', response.body
    end

    test 'user sign up fails' do
        get signup_path
        assert_template 'users/new'
        assert_no_difference 'User.count' do
            post users_path, params: { user: {username: '', email: 'dan@gmail.com', password: '123'}}
        end
        assert_template 'users/new'
    end
end