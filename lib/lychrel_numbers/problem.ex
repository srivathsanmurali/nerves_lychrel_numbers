defmodule LychrelNumbers.Problem do
  import Ecto.Query
  
  def enqueue(start_number, end_number) do
    problems = start_number..end_number
    |> Enum.map(fn x ->
      %{number: x, status: "free", last_number: Integer.to_string(x), count: 0}
      end)

    LychrelNumbers.Repo.insert_all "problems", problems
  end

  defp waiting(limit) do
    from p in "problems",
      where: p.status == "free",
      limit: ^limit,
      select: p.id,
      lock: "FOR UPDATE SKIP LOCKED" 
  end

  def take(limit) do
    {:ok, {count, events}} =
      LychrelNumbers.Repo.transaction fn ->
        ids = LychrelNumbers.Repo.all waiting(limit)
        LychrelNumbers.Repo.update_all by_ids(ids), [set: [status: "running"]], [returning: [:id, :number, :last_number, :count]]
      end
    {count, events}
  end

  defp by_ids(ids) do
    from t in "problems", where: t.id in ^ids
  end

  def update_status(id, status) do
    LychrelNumbers.Repo.update_all by_ids([id]), set: [status: status]
  end

  def update_problem(id, status, last_number, count) do
    LychrelNumbers.Repo.update_all by_ids([id]), [set: [status: status, last_number: last_number, count: count]]
  end

end
