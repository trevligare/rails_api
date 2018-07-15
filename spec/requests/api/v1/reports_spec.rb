# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/report', type: :request do

  describe 'POST /' do

    before(:all) do
      @source = create(:source)
      @reporter = create(:reporter, uuid: FFaker::Guid.guid, source: @source)
      create(:label, slug: 'nothing')
      create(:label, slug: 'hate')
      create(:label, slug: 'threat')
      @create_path = '/api/v1/reports/'
    end

    it 'returns 200 when submitting a nice report' do
      text = FFaker::Tweet.tweet
      result = post_json @create_path, { label: 'nothing', text: text, token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(201)
      statement = Statement.find(result[:id])
      expect(statement.text).to eq(text)
      expect(statement.classifications.first.label.slug).to eq('nothing')
      expect(statement.reporter.uuid).to eq(@reporter.uuid)
      expect(statement.reporter.source.token).to eq(@source.token)
    end

    it 'returns 200 when submitting a hate report' do
      text = 'azd'
      result = post_json @create_path, { label: 'hate', text: text, token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(201)
      statement = Statement.find(result[:id])
      expect(statement.text).to eq(text)
      expect(statement.classifications.first.label.slug).to eq('hate')
      expect(statement.reporter.uuid).to eq(@reporter.uuid)
      expect(statement.reporter.source.token).to eq(@source.token)
    end

    it 'returns the id of the stored statement' do
      text = 'azd'
      result = post_json '/api/v1/reports', { label: 'threat', text: text, token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(201)
      statement = Statement.find(result[:id])
      expect(statement.text).to eq(text)
      expect(statement.classifications.first.label.slug).to eq('threat')
      expect(statement.reporter.uuid).to eq(@reporter.uuid)
      expect(statement.reporter.source.token).to eq(@source.token)
    end

    it 'returns 400 when missing all parameters' do
      post_json @create_path
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing text parameter' do
      post_json @create_path, { classification: 'hate', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing classification parameter' do
      post_json @create_path, { text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing token parameter' do
      post_json @create_path, { text: 'azd', classification: 'hate', reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when missing reporter parameter' do
      post_json @create_path, { text: 'azd', classification: 'hate', token: @source.token }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end

    it 'returns 400 when classifiaction is not registered' do
      post_json @create_path, { classification: 'blerg', text: 'azd', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(400)
      expect(Statement.all.count).to eq(0)
    end
  end
end
