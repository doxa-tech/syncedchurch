module ExceptionsHandler

  extend ActiveSupport::Concern

  included do

    rescue_from Adeia::AccessDenied do |exception|
      respond_to do |format|
        format.html do
          redirect_to dashboard_path, error: t("application.unauthorized")
        end
        format.all { render nothing: true, status: 403 }
      end
    end

    rescue_from Adeia::LoginRequired do |exception|
      respond_to do |format|
        format.html do
          redirect_to login_path, error: t("application.login_required")
          format.all { render nothing: true, status: 401 }
        end
      end
    end

  end

end
