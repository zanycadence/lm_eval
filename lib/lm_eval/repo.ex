defmodule LmEval.Repo do
  use Ecto.Repo,
    otp_app: :lm_eval,
    adapter: Ecto.Adapters.Postgres
end
