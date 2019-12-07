# require 'minitest/autorun'
require 'test_helper'

module V1
  module Public
    class UserIntegrationTest < ActionDispatch::IntegrationTest
      def setup
        @headers = { 'Content-Type': 'application/vnd.api+json' }
      end

      test 'can get user' do
        uuid = users(:user_1).id
        get "/v1/public/users/#{uuid}", headers: @headers
        assert_response 200
        json = JSON.parse(@response.body)
        assert_equal ':icecream:', json['data']['attributes']['emoji']
        assert_equal '/images/icecream.png', json['data']['attributes']['image']
      end

      test 'can create user' do
        @params = {
          data: {
            type: 'user',
            attributes: {
              emoji: 'panda',
              image: '/images/panda.png'
            }
          }
        }
        post '/v1/public/users', params: @params, headers: @headers, as: :json
        assert_response 201
        body = JSON.parse(response.body)
        refute_nil body['data']['id']
        assert_equal 'user', body['data']['type']
      end
    end
  end
end
