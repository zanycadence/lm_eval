defmodule LmEval.Repo.Migrations.CreateHellaSwag do
  use Ecto.Migration

  def change do
    create table(:hellaswags) do
      add :ind, :integer
      add :activity_label, :text
      add :ctx, :text
      add :ctx_a, :text
      add :ctx_b, :text
      add :endings, {:array, :text}
      add :label, :integer
      add :split, :string
      add :split_type, :string
      add :source_id, :string
    end
  end
end
