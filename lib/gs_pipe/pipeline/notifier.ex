defmodule GsPipe.Pipeline.Notifier do
  @moduledoc false

  use GenStage
  require Logger

  @dummy_state []

  def start_link([name, subscription_options]) do
    GenStage.start_link(__MODULE__, subscription_options, name: name)
  end

  def init(subscription_options) do
    Logger.debug(fn -> "#{inspect(self())}: #{__MODULE__} started." end)
    {:consumer, @dummy_state, subscription_options}
  end

  def handle_events(tasks, _from, _state) do
    Enum.each(tasks, &notify(&1))
    {:noreply, [], @dummy_state}
  end

  # Private

  defp notify(:error), do: Logger.debug(fn -> "#{inspect self()}: Error Notification" end)
  defp notify(task), do: Logger.debug(fn -> "#{inspect self()}: Notification for #{inspect task}" end)
end
