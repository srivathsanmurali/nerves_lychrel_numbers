defmodule LychrelNumbers.ProblemStore do
  use GenStage

  #@name {:global, :lychrelStore} 
  @name __MODULE__ 
  @max_limit 1_000_000
  
  def start_link(counter) do
    GenStage.start_link(__MODULE__, counter, name: @name)
    #case GenStage.start_link(__MODULE__, counter, name: @name) do
    #  {:ok, pid} ->
    #    IO.puts "Started #{__MODULE__} master"
    #    {:ok, pid}
    #  {:error, {:already_started, pid}} ->
    #    IO.puts "Started #{__MODULE__} slave"
    #    {:ok, pid}
    #end
  end

  def init(counter) do
    {:producer, counter}
  end

  def handle_info(:enqueued, state) do
    serve_jobs(state)
  end

  def handle_demand(demand, state) when state < @max_limit do
    serve_jobs(demand + state)
  end

  defp serve_jobs(0) do
    {:noreply, [], 0}
  end

  defp serve_jobs(limit) when limit > 0 do
    {count, events} = LychrelNumbers.Problem.take(limit)
    Process.send_after(@name, :enqueued, 60_000)
    {:noreply, events, limit - count}
  end

end
