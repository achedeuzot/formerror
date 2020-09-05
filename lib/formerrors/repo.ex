defmodule Formerrors.Repo do
  use Ecto.Repo,
    otp_app: :formerrors,
    adapter: Ecto.Adapters.Postgres
end
