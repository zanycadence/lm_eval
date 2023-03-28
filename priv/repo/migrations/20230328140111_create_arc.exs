defmodule LmEval.Repo.Migrations.CreateArc do
  use Ecto.Migration

  def change do
    create table(:arcs) do
      add :answerKey, :string
      add :question_choices, {:array, :jsonb}
      add :ref_id, :string
      add :question_stem, :text
      add :difficulty, :string
      add :split, :string
    end
  end
end
