defmodule LychrelNumbers.Repo.Migrations.AddTable do
  use Ecto.Migration

  def change do
    create table(:problems) do
      add :number, :bigint
      add :status, :string
      add :last_number, :bigint
      add :count, :int
    end
  end
end
