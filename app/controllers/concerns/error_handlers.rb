module ErrorHandlers
  extend ActiveSupport::Concern

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end
  class RecordNotFound < ActionController::ActionControllerError; end
  class ParameterMissing < ActionController::ActionControllerError; end


  included do
    rescue_from StandardError, with: :rescue500
    rescue_from Forbidden, with: :rescue403
    rescue_from IpAddressRejected, with: :rescue403
    rescue_from RecordNotFound, with: :rescue404
    rescue_from ParameterMissing, with: :rescue400
  end

  private def rescue400(e)
    render "errors/bad_request", status: 400
  end

  private def rescue403(e)
    @exception = e
    render "errors/forbidden", status: 403
  end

  private def rescue404(e)
    render "errors/not_found", status: 404
  end

  private def rescue500(e)
    render "errors/internal_server_error", status: 500
  end
end
