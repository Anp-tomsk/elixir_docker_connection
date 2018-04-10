defmodule Sub.Subscriber do
  alias Sub.ServerState
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, %{}, name: :consumer)
  end

  def init(_state) do
    schedule_work()
    {:ok, %{is_connected: false}}
  end

  def handle_cast({:time, time}, state) do
    ServerState.set_state(time)
    {:noreply, state}
  end

  def handle_info(:work, %{is_connected: false}) do
    IO.puts("Attempt to connect")
    {:noreply, %{is_connected: Node.connect(:"pub@publisher")}}
  end

  def handle_info(:work, %{is_connected: true}=state) do
    IO.puts("Conencted succesfully")
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1000)
  end

end
