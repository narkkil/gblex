defmodule Gblex do
  @moduledoc """
  Documentation for Gblex.
  """

  def entries_dir, do: "entries"
  def template_file, do: "lib/templates/template.html.eex"

  def render({entry_name, markdown}) when is_binary(markdown) do
    {entry_name, Earmark.as_html!(markdown)}
  end

  @doc """
    Writes a given entry tuple into the configured Github Pages directory.
  """
  def write_entry({name, html}) do
    "#{build_dir()}/#{name}.html"
    |> File.write!(html)
  end

  def new_entry(name) do
    File.write!("#{entries_dir()}/#{name}", "")
  end

  def build(build_dir) do
    if !File.exists?(build_dir) do
      File.mkdir!(build_dir)
    end

    File.ls!(entries_dir())
    |> Enum.filter_map(&is_md?/1, &read_entry/1)
    |> Enum.map(&render/1)
    |> Enum.each(&write_entry/1)
  end

  def is_md?(filename), do: String.ends_with?(filename, ".md")

  @doc """
    Reads a `filename` into a tuple containing the entry name and file contents.
    Files come directly from `File.ls!` and have no path
    prefix (it is prepended).
  """
  def read_entry(filename) do
    entry_name =
        filename
        |> String.split(".")
        |> List.first

    file =
      "#{entries_dir()}/#{filename}"
      |> File.read!

    {entry_name, file}
  end

  def initialize do
  end

  def publish do
  end
end
