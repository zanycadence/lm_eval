defmodule LmEval.Repo.Migrations.CreateBoolq do
  use Ecto.Migration

  def change do
    create table(:boolqs) do
      add :answer, :boolean
      add :passage, :text
      add :question, :text
      add :title, :text
      add :split, :string
    end
  end
end
