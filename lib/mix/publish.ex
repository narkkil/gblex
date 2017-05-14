defmodule Mix.Tasks.Gblex.Publish do
  use Mix.Task

  def run(_) do
    date = Date.utc_today |> Date.to_iso8601
    username = Application.fetch_env!(:gblex, :github_username)

    Gblex.publish(username, date)
  end
end
