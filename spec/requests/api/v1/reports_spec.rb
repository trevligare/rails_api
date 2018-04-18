# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/report', type: :request do
  describe 'POST /' do
    it 'returns 200 when submitting a nice report' do
      post_json '/api/v1/reports/', { nice: '1', text: 'azd' }
      expect(response).to have_http_status(200)
    end

    it 'returns 200 when submitting a not so nice report' do
      post_json '/api/v1/reports/', { nice: '0', text: 'azd' }
      expect(response).to have_http_status(200)
    end

    it 'returns the id of the stored statement' do
      result = post_json '/api/v1/reports', { nice: '0', text: 'azd' }
      expect(response).to have_http_status(200)
      expect(Statement.find(result[:id]).text).to eq('azd')
    end

    it 'returns 400 when missing parameters' do
      post_json '/api/v1/reports/'
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when missing nice parameter' do
      post_json '/api/v1/reports/', { text: 'azd' }
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when missing text parameter' do
      post_json '/api/v1/reports/', { nice: '1' }
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when nice parameter is malformed' do
      post_json '/api/v1/reports/', { nice: 'blerg', text: 'azd' }
      expect(response).to have_http_status(400)
    end
  end
end
