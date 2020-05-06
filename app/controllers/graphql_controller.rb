class GraphqlController < ApplicationController
  before_action :requires_login

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    result = CarpassSchema.execute query, variables: variables,
                                          context: context,
                                          operation_name: operation_name
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def context
    {
      current_user: current_user
    }
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  def requires_login
    return if logged_in?
    render json: {errors: ['You are not authenticated']}, status: :unauthorized
  end
end
