require "simple_err_rails/version"

module SimpleErrRails
  class Middleware
    def initialize app
      @app = app
    end

    def call env
      begin
        @status, @headers, @response = @app.call(env)
      rescue Exception => e
        simpleerr_payload = {
          exception_name: e.class.to_s,
          message: e.message
        }
        Rails.logger.info "CAUGHT THE ERROR #{simpleerr_payload}"
        raise e
      end
      [@status, @headers, @response]
    end
  end
end
