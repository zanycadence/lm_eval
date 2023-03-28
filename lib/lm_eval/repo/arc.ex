defmodule LmEval.Repo.Arc do
  @moduledoc """
  ARC is a set of multiple choice reasoning questions for benchmarking language models.

  Keys are as follows
  - `:answerKey`: The correct answer to the question
  - `:question_choices`: an array of labels / text options in a map for the question
  - `:question_stem`: the question
  - `:ref_id` - a unique identifier for the question from ARC
  - `:difficulty` - whether it's from the easy or challenge datasets
  - `:split` - whether it's from the train, dev, or test data split
  """

  import Ecto.Changeset
  use Ecto.Schema

  schema "arcs" do
    field :answerKey, :string
    field :question_choices, {:array, :map}
    field :question_stem, :string
    field :ref_id, :string
    field :difficulty, :string
    field :split, :string
  end

  def changeset(arc, attrs \\ %{}) do
    arc
    |> cast(attrs, [:answerKey, :question_choices, :question_stem, :ref_id, :difficulty, :split])
    |> validate_required([:answerKey, :question_choices, :question_stem, :ref_id, :difficulty, :split])
  end

end
