defmodule LmEval.Repo.Migrations.CreatePiqa do
  use Ecto.Migration

  def change do
    create table(:piqas) do
      add :goal, :text
      add :sol1, :text
      add :sol2, :text
      add :label, :integer
      add :split, :string
    end
  end
end
