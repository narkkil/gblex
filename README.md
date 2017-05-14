# Gblex

Github Pages powered blogging engine focusing on:
* minimum LoC
* minimum dependencies
* minimum amount of features
* minimum time spent from `git clone` to working blog

## Getting started

1. Ensure you have Elixir, Git and Git configured to work with Github
1. Create your Github Pages repository on Github
    - Important: Only add the bare repo if you wish to publish your blog
    via `mix gblex.publish`
2. Clone this repository
3. Run the following commands inside your local clone:

```elixir
mix deps.get
mix gblex.init
mix gblex.new "My first blog post"
mix gblex.publish
```

`entries/` contains a sample blog entry which you may wish to delete.

You're done!
