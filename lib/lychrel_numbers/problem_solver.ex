defmodule LychrelNumbers.ProblemSolver do
  alias LychrelNumbers.{LychrelSolver,Problem}

  def start_link(event) do
    Task.start_link(__MODULE__, :run_problem, [event])
  end

  def run_problem(event) do
      {start_number, _} = Integer.parse(event.last_number)
      case LychrelSolver.lychrel_search(start_number) do
        {:completed, _original, trace, count} -> 
          {:ok, last_number} = Enum.fetch(trace, -1)
          Problem.update_problem(event.id, "completed", Integer.to_string(last_number), event.count + count)
        {:out_of_limit, _original, trace, count} ->
          {:ok, last_number} = Enum.fetch(trace, -1)
          Problem.update_problem(event.id, "free", Integer.to_string(last_number), event.count + count)
      end
      {:ok}
  end

end
