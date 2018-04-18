# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/detect', type: :request do
  describe 'POST /' do
    create_path = '/api/v1/detect/'
    it 'returns 501 when requesting a detection' do
      post_json create_path, { text: 'azd' }
      expect(response).to have_http_status(501)
    end
  end
end
