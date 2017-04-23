defmodule Mix.Tasks.Gblex.Build do
  use Mix.Task

  def run(_) do
    build_dir = Application.fetch_env!(:gblex, :github_username) <> ".github.io"
    Gblex.build(build_dir)
  end
end
