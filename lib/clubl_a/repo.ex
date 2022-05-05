defmodule ClubLA.Repo do
  use Ecto.Repo,
    otp_app: :clubl_a,
    adapter: Ecto.Adapters.Postgres
end
