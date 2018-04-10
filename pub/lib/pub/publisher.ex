defmodule Pub.Publisher do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    broadcast_time()
    schedule_work()
    {:noreply, state}
  end

  defp broadcast_time() do
    broadcast_to(Node.list(), DateTime.utc_now())
  end

  defp broadcast_to([], _time),
    do: IO.puts("No connected nodes to broadcast")

  defp broadcast_to(nodes, time),
    do: nodes
      |> Enum.map(fn node ->
        broadcast_to_node(node, time)
      end)

  defp broadcast_to_node(node, time) do
    IO.inspect("Broadcast to node #{node}")
    GenServer.cast({:consumer, node}, {:time, time})
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1000)
  end

end
