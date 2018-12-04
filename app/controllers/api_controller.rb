# encoding: utf-8

class ApiController < ApplicationController
  before_action :check_json_request

  helper_method :current_user

  rescue_from Exception,                           with: :render_error
  rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
  rescue_from AbstractController::ActionNotFound,  with: :render_not_found

  def check_json_request
    head :not_acceptable unless request.content_type =~ /json/
  end

  def render_error(exception)
    logger.error(exception)
    render json: { error: 'An error ocurred' }, status: 500 unless performed?
  end

  def render_not_found(exception)
    logger.info(exception)
    render json: { error: "Couldn't find the record" }, status: :not_found
  end

  def render_record_invalid(exception)
    logger.info(exception)
    render json: { errors: exception.record.errors.as_json }, status: :bad_request
  end
end
