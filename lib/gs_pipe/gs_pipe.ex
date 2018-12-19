defmodule GsPipe do
  alias GsPipe.Queue

  def multi_enqueue(n, data) do
    0..n
    |> Enum.each(&enqueue({data, &1}))
  end

  def enqueue(data) do
    Queue.enqueue(data)
  end
end
