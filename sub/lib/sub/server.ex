defmodule Sub.Server do
  alias Plug.Adapters.Cowboy2
  alias Sub.ServerState
  alias Plug.Conn

  def start() do
    Cowboy2.http(Sub.Server, [])
  end

  def init(default_options) do
    default_options
  end

  def call(conn, _options) do
    conn
    |> Conn.send_resp(200, ServerState.get_state())
  end

end
