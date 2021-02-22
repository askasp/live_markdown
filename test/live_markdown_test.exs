defmodule LiveMarkdownTest do
  use ExUnit.Case
  doctest LiveMarkdown

  test "greets the world" do
    assert LiveMarkdown.hello() == :world
  end
end
