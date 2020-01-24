# require 'minitest/autorun'
require 'test_helper'

module V1
  module Public
    class UserIntegrationTest < ActionDispatch::IntegrationTest
      def setup
        @headers = { 'Content-Type': 'application/vnd.api+json' }
        @uuid = users(:user_1).id
      end

      test 'can show user' do
        get "/v1/public/users/#{@uuid}", headers: @headers
        assert_response 200
        json = JSON.parse(@response.body)
        assert_equal ':icecream:', json['data']['attributes']['emoji']
        assert_equal '/images/icecream.png', json['data']['attributes']['image']
        assert_nil json['data']['attributes']['latitude']
        assert_nil json['data']['attributes']['longitude']
        assert_equal false, json['data']['attributes']['share-geo']
      end

      test 'index user is forbidden' do
        get "/v1/public/users/", headers: @headers
        assert_response 200
        # TODO: add more rigid tests here
      end

      test 'can create user' do
        @params = {
          data: {
            type: 'user',
            attributes: {
              emoji: 'panda',
              image: '/images/panda.png',
            }
          }
        }
        post '/v1/public/users', params: @params, headers: @headers, as: :json
        assert_response 201
        body = JSON.parse(response.body)
        refute_nil body['data']['id']
        assert_equal 'user', body['data']['type']
      end

      test 'can update user' do
        @params = {
          data: {
            type: 'user',
            attributes: {
              emoji: 'panda',
              image: '/images/panda.png',
              share_geo: true
            }
          }
        }
        put "/v1/public/users/#{@uuid}", params: @params, headers: @headers, as: :json
        assert_response 200
        body = JSON.parse(response.body)
        assert_equal true, body['data']['attributes']['share-geo']
      end

      test 'delete user is forbidden' do
        delete "/v1/public/users/#{@uuid}", headers: @headers
        assert_response 403
      end
    end
  end
end
