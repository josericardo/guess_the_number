defmodule GuessTheNumber.Repo do
  use Ecto.Repo,
    otp_app: :guess_the_number,
    adapter: Ecto.Adapters.Postgres
end
