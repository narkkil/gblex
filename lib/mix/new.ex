defmodule Mix.Tasks.Gblex.New do
  use Mix.Task

  def run([name | _]) do
    date = Date.utc_today |> Date.to_iso8601

    filename = "#{date}-#{name}.md"
    Gblex.new_entry(name, filename)
  end
end
