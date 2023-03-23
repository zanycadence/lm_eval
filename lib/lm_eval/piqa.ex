defmodule LmEval.PIQA do
  @moduledoc """
  Physical Interaction: Question Answering (PIQA) is a dataset used to train/evaluate a LM's physical knowledge.

  This module contains types and functions for working with PIQA.

  Keys are as follows
  - `:goal`: A goal related to a physical interaction that a model has to choose the most appropriate solution to
  - `:sol1`: A proposed solution to the goal
  - `:sol2`: A second proposed solution to the goal
  - `:label`: 0 (sol1) or 1 (sol2), blank if from test split
  - `:split`: if the data is from the train, val, or test datasets
  """

  import Ecto.Changeset
  use Ecto.Schema

  schema "piqas" do
    field :goal, :string
    field :sol1, :string
    field :sol2, :string
    field :label, :integer
    field :split, :string
  end

  def changeset(piqa, attrs \\ %{}) do
    piqa
    |> cast(attrs, [:goal, :sol1, :sol2, :label, :split])
  end
end
