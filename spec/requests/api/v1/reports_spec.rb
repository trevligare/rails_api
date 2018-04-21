# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/report', type: :request do

  describe 'POST /' do

    before(:all) do
      @source = create(:source)
      @reporter = build(:reporter, uuid: FFaker::Guid.guid, source: @source)
      @create_path = '/api/v1/reports/'
    end

    it 'returns 200 when submitting a nice report' do
      text = FFaker::Tweet.tweet
      result = post_json @create_path, { nice: '1', text: text, token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(201)
      statement = Statement.find(result[:id])
      expect(statement.text).to eq(text)
      expect(statement.nice).to eq(true)
      expect(statement.reporter.uuid).to eq(@reporter.uuid)
      expect(statement.reporter.source.token).to eq(@source.token)
    end

    it 'returns 200 when submitting a not so nice report' do
      text = 'azd'
      result = post_json @create_path, { nice: '0', text: text, token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(201)
      statement = Statement.find(result[:id])
      expect(statement.text).to eq(text)
      expect(statement.nice).to eq(false)
      expect(statement.reporter.uuid).to eq(@reporter.uuid)
      expect(statement.reporter.source.token).to eq(@source.token)
    end

    it 'returns the id of the stored statement' do
      text = 'azd'
      result = post_json '/api/v1/reports', { nice: '0', text: text, token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(201)
      statement = Statement.find(result[:id])
      expect(statement.text).to eq(text)
      expect(statement.nice).to eq(false)
      expect(statement.reporter.uuid).to eq(@reporter.uuid)
      expect(statement.reporter.source.token).to eq(@source.token)
    end

    it 'returns 400 when missing all parameters' do
      post_json @create_path
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing text parameter' do
      post_json @create_path, { nice: '1', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing nice parameter' do
      post_json @create_path, { text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing token parameter' do
      post_json @create_path, { text: 'azd', nice: '1', reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing reporter parameter' do
      post_json @create_path, { text: 'azd', nice: '1', token: @source.token }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when nice parameter is malformed' do
      post_json @create_path, { nice: 'blerg', text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end
  end
end
