# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/classification', type: :request do

  describe 'POST /' do

    before(:all) do
      @source = create(:source)
      @reporter = create(:reporter, uuid: FFaker::Guid.guid, source: @source)
      create(:label, slug: 'nothing')
      create(:label, slug: 'hate')
      create(:label, slug: 'threat')
      @create_path = '/api/v1/classifications/'
    end

    before(:each) do
      @statement = create(:statement)
    end

    it 'returns 200 when submitting a nice report' do
      text = FFaker::Tweet.tweet
      result = post_json @create_path, { statement: @statement.id, label: 'threat', token: @source.token, reporter: @reporter.uuid }
      expect(response).to have_http_status(201)
      expect(@statement.classifications.last.label.slug).to eq('threat')
    end
  end
end
