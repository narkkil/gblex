defmodule Gblex do
  @moduledoc """
  Documentation for Gblex.
  """

  @blog_title Application.fetch_env!(:gblex, :blog_title)

  def entries_dir, do: "entries"
  def template_file, do: "lib/templates/template.html.eex"
  def build_dir, do: Application.fetch_env!(:gblex, :github_username) <> ".github.io"

  def render({entry_name, markdown}) when is_binary(markdown) do
    entry_html = Earmark.as_html!(markdown)
    opts = [blog_title: @blog_title,
            body: entry_html]

    html = EEx.eval_file(template_file(), opts)
    {entry_name, html}
  end

  @doc """
    Writes a given entry tuple into the configured Github Pages directory.
  """
  def write_entry({name, html}) do
    "#{build_dir()}/#{slug(name)}.html"
    |> File.write!(html)
  end

  def new_entry(title, filename) do
    File.write!("#{entries_dir()}/#{filename}", "## #{title}")
  end

  def build(build_dir) do
    if !File.exists?(build_dir), do: File.mkdir!(build_dir)

    File.copy!("lib/templates/style.css", "#{build_dir}/style.css")

    entries =
      File.ls!(entries_dir())
      |> Enum.filter_map(&is_md?/1, &read_entry/1)

    render_index(entries)
    render_entries(entries)
  end

  def render_index(entries) do
    entries =
      entries
      |> Keyword.keys
      |> Enum.map(&date_title_and_slug/1)

    rendered_index = EEx.eval_file("lib/templates/index.html.eex", [entries: entries])
    index_html = EEx.eval_file(template_file(), [body: rendered_index,
                                                 blog_title: @blog_title])

    File.write("#{build_dir()}/index.html", index_html)
  end

  def render_entries(entries) do
    entries
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

  defp slug(entry) do
    entry
    |> String.downcase
    |> String.replace("'", "")
    |> String.replace(" ", "-")
  end

  defp date(entry) do
    entry
    |> String.splitter("-")
    |> Enum.take(3)
    |> Enum.join("-")
    |> Date.from_iso8601!
  end

  defp title(entry) do
    entry
    |> String.split("-")
    |> List.last
  end

  defp date_title_and_slug(entry), do: {date(entry), title(entry), slug(entry)}

  def initialize do
  end

  def publish do
  end
end
