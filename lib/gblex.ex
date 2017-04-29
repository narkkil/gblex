defmodule Gblex do
  @moduledoc """
  Documentation for Gblex.
  """

  alias Gblex.Entry

  @blog_title Application.fetch_env!(:gblex, :blog_title)

  def entries_dir, do: "entries"
  def template_file, do: "lib/templates/template.html.eex"
  def build_dir, do: Application.fetch_env!(:gblex, :github_username) <> ".github.io"

  def render(markdown) when is_binary(markdown), do: Earmark.as_html!(markdown)
  def render(entry = %Entry{}) do
    opts = [blog_title: @blog_title, entry_date: entry.date, body: render(entry.markdown)]

    Map.put(entry, :html,  EEx.eval_file(template_file(), opts))
  end

  @doc """
    Writes a given entry tuple into the configured Github Pages directory.
  """
  def write(entry = %Entry{}) do
    "#{build_dir()}/#{entry.slug}.html"
    |> File.write!(entry.html)
  end

  def new_entry(title, filename) do
    File.write!("#{entries_dir()}/#{filename}", "## #{title}")
  end

  def build(build_dir) do
    if !File.exists?(build_dir), do: File.mkdir!(build_dir)

    File.copy!("lib/templates/style.css", "#{build_dir}/style.css")

    entries =
      File.ls!(entries_dir())
      |> Enum.filter_map(&is_md?/1, &Entry.read_entry/1)
      |> Enum.sort(&(&1.date > &2.date))

    render_index(entries)
    render_entries(entries)
  end

  def render_index(entries) do
    rendered_index = EEx.eval_file("lib/templates/index.html.eex", [entries: entries])
    index_html = EEx.eval_file(template_file(), [body: rendered_index,
                                                 entry_date: nil,
                                                 blog_title: @blog_title])

    File.write("#{build_dir()}/index.html", index_html)
  end

  def render_entries(entries) do
    entries
    |> Enum.map(&render/1)
    |> Enum.each(&write/1)
  end

  def is_md?(filename), do: String.ends_with?(filename, ".md")

  def initialize do
  end

  def publish do
  end
end
