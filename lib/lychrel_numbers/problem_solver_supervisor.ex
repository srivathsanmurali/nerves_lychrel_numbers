defmodule LychrelNumbers.ProblemSolverSupervisor do
  use ConsumerSupervisor

  def start_link do
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(LychrelNumbers.ProblemSolver, [], restart: :temporary)
    ]

    {:ok, children, strategy: :one_for_one, subscribe_to: [
        {LychrelNumbers.ProblemStore, min_demand: 10, max_demand: 20}
      ]
    }
  end
end
