defmodule LychrelNumbers.Repo.Migrations.UseStringForLastNumber do
  use Ecto.Migration

  def change do
    alter table(:problems) do
      modify :last_number, :string
    end
  end
end
