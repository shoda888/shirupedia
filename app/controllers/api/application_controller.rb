class Api::ApplicationController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protect_from_forgery with: :null_session

  rescue_from Exception, with: :response_internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :response_not_found
  rescue_from ActionController::RoutingError, with: :response_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :response_bad_request
  rescue_from ActiveModel::ValidationError, with: :response_bad_request

  def auth
    ## 認証に失敗したらエラーレスポンスを返す
    authenticate || response_unauthorized
  end

  def authenticate
    authenticate_with_http_token do |token, _options|
      auth_user = User.find_by(token: token)
      if !auth_user.nil?
        @current_user = auth_user
        true
      else
        false
      end
    end
  end

  # 200 Success
  def response_success(class_name, action_name, id = nil)
    render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}", id: id }
  end

  def signin_success(class_name, action_name, data = nil, id = nil)
    render status: 200, json: { status: 200, message: "Success #{class_name.capitalize} #{action_name.capitalize}", token: data, id: id }
  end

  # 400 Bad Request
  def response_bad_request(e = nil)
    render status: 400, json: { status: 400, message: 'Bad Request', error_content: e }
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 404 Not Found
  def response_not_found(e = nil)
    render status: 404, json: { status: 404, message: 'Not Found', error_content: e }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error(e = nil)
    render status: 500, json: { status: 500, message: 'Internal Server Error', error_content: e }
  end
end
