
defmodule LiveMarkdown do
    use GenServer
  @moduledoc """
  Documentation for `LiveMarkdown`.
  """

  @refresh_time Application.get_env(:live_markdown, :refresh_time, 15*60*1000)

  def start_link(_), do: GenServer.start_link(__MODULE__, "", name: __MODULE__)
  def html_from_md_path(path), do: GenServer.call(__MODULE__, {:get, path})

  def init(_) do
      send(self(), :refresh)
      {:ok, %{}}
      end

  def handle_call({:get, path}, _from, state) do
      case Map.get(state, path) do
          nil -> tmp =html_from_markdown(path)
                 {:reply, tmp, Map.put(state, path, tmp)}
          x -> {:reply, x, state}
          end
  end

  def handle_info(:refresh, state) do
      new_pages =
      Enum.map(state, fn {k,_} ->
          new = html_from_markdown(k)
          {k, new} end)
          |> Enum.into(%{})

      Process.send_after(self(), :refresh, @refresh_time)
      {:noreply, new_pages}
  end


   defp html_from_markdown(link) do
       {:ok, {{_, 200, 'OK'}, _headers, body}} =
        :httpc.request(:get, {link, []}, [], [])
        body = ~s(#{body})
        Earmark.as_html!(body)
   end


end
