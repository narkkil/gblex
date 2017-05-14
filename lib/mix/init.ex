defmodule Mix.Tasks.Gblex.Init do
  use Mix.Task

  def run(_) do
    username = Application.fetch_env!(:gblex, :github_username)
    Gblex.initialize(username)
  end
end
