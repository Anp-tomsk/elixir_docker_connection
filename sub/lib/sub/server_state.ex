defmodule Sub.ServerState do
  use Agent
  @name :server_state

  def start_link([]) do
    Agent.start_link(
      fn -> "Not provided" end,
      name: @name
    )
  end

  def set_state(time) do
    Agent.update(@name, fn _ -> DateTime.to_string(time) end)
  end

  def get_state() do
    Agent.get(@name, fn state -> state end)
  end

end
