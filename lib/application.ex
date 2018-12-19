defmodule GsPipe.Application do
  @moduledoc false

  use Application

  alias GsPipe.Queue
  alias GsPipe.PipelineSup

  def start(_type, _args) do
    children = [
      {Queue, []},
      PipelineSup,
    ]

    opts = [strategy: :one_for_one, name: GsPipe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
