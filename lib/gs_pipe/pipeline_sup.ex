defmodule GsPipe.PipelineSup do
  use Supervisor

  alias GsPipe.Pipeline.{
    Producer,
    Worker,
    Notifier
  }

  @starter_name Producer
  @default_nbr_workers 15

  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    worker_subscription = [
      subscribe_to: [{@starter_name, min_demand: 1, max_demand: 10}]
    ]

    # Create a number of consumer, all connected to the same producer
    worker_specs = (0..nbr_workers()) |> Enum.map(fn i ->
      name = :"worker_#{i}"
      Supervisor.child_spec({Worker, [name, worker_subscription]}, id: name)
    end)

    notifier_subs = (0..nbr_workers()) |> Enum.map(fn i ->
      {:"worker_#{i}", min_demand: 1, max_demand: 10}
    end)

    notifier_subscription = [
      subscribe_to: notifier_subs
    ]

    notifier_spec = Supervisor.child_spec({Notifier, [:notifier_step, notifier_subscription]}, id: :notifier_step)

    children = [worker(Producer, [], restart: :permanent)] ++
      worker_specs ++
      [notifier_spec]

    Supervisor.init(
      children,
      strategy: :rest_for_one
    )
  end

  # Private

  defp nbr_workers do
    Application.get_env(:gs_pipe, :pipeline)[:nbr_workers] || @default_nbr_workers
  end
end
