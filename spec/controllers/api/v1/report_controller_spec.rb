# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReportController, type: :controller do
  describe 'GET #create' do
    it 'returns http success' do
      post :create
      expect(response).to be_successful
    end
  end
end
