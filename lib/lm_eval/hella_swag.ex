defmodule LmEval.HellaSwag do
  @moduledoc """
  The HellaSwag dataset is used to train/evaluate a LM's ability to accurately predict sentence endings from a context.

  This module contains types and functions for working with HellaSwag to evaluate different language models.

  Keys are as follows
  - `:ind`: Dataset ID
  - `:activity_label`: ActivityNet or WikiHow label for the example
  - `:ctx`: The full context. For models that need the last sentence to be complete, use `:ctx_a`
  - `:ctx_a`: The context as a complete sentence, minus any trailing incomplete noun phrase
  - `:ctx_b`: The trailing incomplete noun phrase
  - `:endings`: An array of four endings.
  - `:label`: Present only in training and validation data. Index of the endings array for the correct ending.
  - `:split`: Whether the data is from the `train`, `val`, or `test` data
  - `:split_type`: If the activity label is seen during training, `indomain`, else `zeroshot`
  - `:source_id`: Which ActivityNet or WikiHow id this example came from
  """

  import Ecto.Changeset
  use Ecto.Schema

  schema "hellaswags" do
    field :ind, :integer
    field :activity_label, :string
    field :ctx, :string
    field :ctx_a, :string
    field :ctx_b, :string
    field :endings, {:array, :string}
    field :label, :integer
    field :split, :string
    field :split_type, :string
    field :source_id, :string
  end

  def changeset(hella_swag, attrs \\ %{}) do
    hella_swag
    |> cast(attrs, [:ind, :activity_label, :ctx, :ctx_a, :ctx_b, :endings, :label, :split, :split_type, :source_id])
  end
end
