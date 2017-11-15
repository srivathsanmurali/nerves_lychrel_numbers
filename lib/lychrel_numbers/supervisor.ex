defmodule LychrelNumbers.Supervisor do
  use Supervisor

  def start_link do
    children = [
      supervisor(LychrelNumbers.Repo, []),
      worker(LychrelNumbers.ProblemStore, [0]),
      worker(LychrelNumbers.ProblemSolverSupervisor, [], id: 1),
    ]
    Supervisor.start_link(children , strategy: :one_for_one)
  end
end
