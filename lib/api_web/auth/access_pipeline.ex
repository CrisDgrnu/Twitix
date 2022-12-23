defmodule ApiWeb.Auth.AccessPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :api_web,
    error_handler: ApiWeb.Auth.AccessErrorHandler,
    module: ApiWeb.Auth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
