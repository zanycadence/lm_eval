defmodule LmEval.Repo.Migrations.CreateSiqa do
  use Ecto.Migration

  def change do
    create table(:siqas) do
      add :context, :text
      add :question, :text
      add :answerA, :text
      add :answerB, :text
      add :answerC, :text
      add :label, :integer
      add :split, :string
    end
  end
end
