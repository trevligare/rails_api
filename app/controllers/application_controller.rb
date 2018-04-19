# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :verify_token

  def verify_token
    return error_code('missing token parameter') if params[:token].blank?
    @source = Source.find_by(token: params[:token])
    return error_code('invalid token', 403) if @source.nil?
    @source
  end

  def error_code(message, code = 400)
    return render json: { error: message }, status: code
  end
end
