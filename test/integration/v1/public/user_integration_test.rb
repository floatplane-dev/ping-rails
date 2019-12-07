require 'test_helper'

module V1
  module Public
    class UserIntegrationTest < ApplicationController
      def setup
        @header = public_header
      end

      test 'can create lead' do
        # params = { data: { attributes: { emoji: ":panda:", image: "/images/panda.png"}, type: "user"}}
        # post '/v1/public/user', headers: @header, params: params
        assert_response 201
        # json = JSON.parse(@response.body)
        # assert_equal 2, json['data'].length
      end
    end
  end
end
