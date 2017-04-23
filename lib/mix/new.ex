defmodule Mix.Tasks.Gblex.New do
  use Mix.Task

  def run([name | _]) do
      date = Date.utc_today |> Date.to_iso8601
      str = format(name)

      "#{date}-#{str}.md"
      |> Gblex.new_entry
  end

  defp format(string) do
      string
      |> String.downcase
      |> String.replace("'", "")
      |> String.replace(" ", "-")
  end
end
