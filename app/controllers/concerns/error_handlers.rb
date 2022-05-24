module ErrorHandlers
  extend ActiveSupport::Concern

  class Forbidden < ActionController::ActionControllerError; end
  class RecordNotSaved < ActiveRecord::RecordNotSaved; end
  class RecordInvalid < ActiveRecord::RecordInvalid; end
  class RecordNotFound < ActiveRecord::RecordNotFound; end
  class RoutingError < ActionController::RoutingError; end
  class ParameterMissing < ActionController::BadRequest; end


  included do
    rescue_from Exception, with: :rescue500
    rescue_from Forbidden, with: :rescue403
    rescue_from RecordNotSaved, with: :rescue422
    rescue_from RecordInvalid, with: :rescue422
    rescue_from RecordNotFound, with: :rescue404
    rescue_from RoutingError, with: :rescue404
    rescue_from ParameterMissing, with: :rescue400
  end

  private def rescue400(e)
    render "errors/bad_request", status: 400
  end

  private def rescue403(e)
    @exception = e
    render "errors/forbidden", status: 403
  end

  def rescue404(e)
    render "errors/not_found", status: 404
  end

  def rescue422(e)
    render "errors/unprocessable_entity", status: 422
  end

  private def rescue500(e)
    render "errors/internal_server_error", status: 500
  end
end
