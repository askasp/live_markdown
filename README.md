# LiveMarkdown

## Use case
I want to display a publicly available markdown file as HTML on my website, but 
I do not want to fetch, and parse, it on every request

## How it works
On calling  LiveMarkdown.html_from_md_path(som_url) the markdown formatted text is 
fetched and parsed to html. It is then stored in-memory for the next request.  
Only the available RAM limits how many pages can be avaliable at the same time.

All markdown files are automatically refetched every 15 minutes which is rather aggressive.
It can be configured by setting the 

``` 
config :live_markdown, :refresh_time, <time_in_minutes>
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `live_markdown` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_markdown, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/live_markdown](https://hexdocs.pm/live_markdown).

