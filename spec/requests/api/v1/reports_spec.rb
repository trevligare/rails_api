# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/report', type: :request do

  describe 'POST /' do

    before(:all) do
      @source = create(:source)
      @reporter = build(:reporter, source: @source)
      @create_path = '/api/v1/reports/'
    end

    it 'returns 200 when submitting a nice report' do
      post_json @create_path, { nice: '1', text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(200)
    end

    it 'returns 200 when submitting a not so nice report' do
      post_json @create_path, { nice: '0', text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(200)
    end

    it 'returns the id of the stored statement' do
      result = post_json '/api/v1/reports', { nice: '0', text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(200)
      expect(Statement.find(result[:id]).text).to eq('azd')
    end

    it 'returns 400 when missing all parameters' do
      post_json @create_path
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when missing text parameter' do
      post_json @create_path, { nice: '1', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when missing nice parameter' do
      post_json @create_path, { text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when missing token parameter' do
      post_json @create_path, { text: 'azd', nice: '1', reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when missing reporter parameter' do
      post_json @create_path, { text: 'azd', nice: '1', token: @source.token }
      expect(response).to have_http_status(400)
    end

    it 'returns 400 when nice parameter is malformed' do
      post_json @create_path, { nice: 'blerg', text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
    end
  end
end
