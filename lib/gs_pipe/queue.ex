defmodule GsPipe.Queue do
  @moduledoc false

  use GenServer
  require Logger

  @name __MODULE__
  @key "queue_key"

  def start_link(_arg), do: GenServer.start_link(__MODULE__, nil, name: @name)

  def dequeue(no_items \\ 1) do
    [{_, queue} | _] = :ets.lookup @name, @key

    # Beware because :queue.split does not act like Enum.split!
    # It generates an error if splitting number is bigger than queue length
    case :queue.len(queue) do
      0 ->
        :queue.to_list(queue)
      x when x <= no_items ->
        :ets.insert(@name, {@key, :queue.new})
        :queue.to_list(queue)
      x when x > no_items ->
        {events, new_queue} = :queue.split(no_items, queue)
        :ets.insert(@name, {@key, new_queue})
        :queue.to_list(events)
    end
  end

  def enqueue(event) do
    [{_, queue} | _] = :ets.lookup @name, @key
    new_queue = :queue.in event, queue
    :ets.insert(@name, {@key, new_queue})
    :ok
  end

  def get_queue() do
    :ets.tab2list(@name)
  end

  @impl GenServer
  def init(_) do
    Logger.debug(fn -> "#{inspect(self())}: Queue worker started." end)

    :ets.new(@name, [:named_table, :public, write_concurrency: true])
    :ets.insert(@name, {@key, :queue.new})
    {:ok, nil}
  end

  @impl GenServer
  def terminate(reason, _state) do
    Logger.debug(fn -> "#{@name} stopped : #{inspect(reason)}" end)
    :ets.delete(@name)
    :ok
  end
end
