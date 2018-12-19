defmodule GsPipe.Pipeline.Worker do
  @moduledoc false

  use GenStage
  require Logger

  @dummy_state []

  def start_link([name, subscription_options]) do
    GenStage.start_link(__MODULE__, subscription_options, name: name)
  end

  def init(subscription_options) do
    Logger.debug(fn -> "#{inspect(self())}: Worker started." end)
    {:producer_consumer, @dummy_state, subscription_options}
  end

  def handle_events(tasks, _from, _state) do
    work = Enum.map(tasks, &process_task(&1))
    {:noreply, work, @dummy_state}
  end

  # PRIVATE

  defp process_task(task) do
    Logger.debug(fn -> "#{inspect self()}: Consume Task #{inspect task}" end)
    task
  end
end
