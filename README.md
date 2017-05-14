# Gblex

Github Pages powered blogging engine focusing on:
* minimum LoC
* minimum dependencies
* minimum amount of features
* minimum time spent from `git clone` to working blog

## Getting started

1. Ensure you have Elixir, Git and Git configured to work with Github
2. Create your Github Pages repository on Github
    - Important: Only add the bare repo if you wish to publish your blog
    via `mix gblex.publish`
3. Clone this repository `git clone https://github.com/narck/gblex`
4. Configure your blog title and Github username in `config/config.exs`
5. Run the following commands inside your local clone:

```elixir
mix deps.get
mix gblex.init
mix gblex.new "My first blog post"
mix gblex.publish
```

`entries/` contains a sample blog entry which you may wish to delete.

By default `gblex` creates a Git repo subdirectory inside your clone which is Git
ignored. You can either use the Mix tasks supplied or use the repo as usual.

That's it!
