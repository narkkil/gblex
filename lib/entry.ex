defmodule Gblex.Entry do
    @enforce_keys [:date, :slug, :markdown, :title]
    defstruct [:date,
               :slug,
               :title,
               :markdown,
               :html]

  @doc """
    Reads a `filename` into a tuple containing an `%Gblex.Entry{}` struct.
    Files come directly from `File.ls!` and have no path
    prefix (it is prepended).
  """
  def read_entry(filename) do
    entry_name =
        filename
        |> String.split(".")
        |> List.first

    markdown =
      "entries/#{filename}"
      |> File.read!

    %Gblex.Entry{markdown: markdown,
                 title: title(entry_name),
                 date: date(entry_name),
                 slug: slug(entry_name)
    }
  end

  defp slug(filename) do
    filename
    |> String.downcase
    |> String.replace("'", "")
    |> String.replace("`", "")
    |> String.replace(" ", "-")
  end

  defp date(filename) do
    filename
    |> String.splitter("-")
    |> Enum.take(3)
    |> Enum.join("-")
    |> Date.from_iso8601!
  end

  defp title(filename) do
    filename
    |> String.split("-")
    |> List.last
    |> String.replace("`", "")
  end
end

