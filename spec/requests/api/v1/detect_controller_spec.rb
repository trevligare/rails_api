# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/detect', type: :request do
  describe 'POST /' do
    it 'returns http success' do
      post_json :create
      expect(response).to be_successful
    end
  end
end
