defmodule LmEval.Repo.SIQA do
  @moduledoc """
  Social Interaction QA (SIQA) is a benchmark for testing social commonsense intelligence.

  This module contains types and functions for working with SIQA.

  Keys are as follows
    - `:context`: The social context used to inform the question
    - `:question`: The question whose correct answer depends on the context
    - `:answerA`, `:answerB`, `:answerC`: answers to the question
    - `:label`: 1 -> A, 2 -> B, 3 -> C for the correct answer (train, dev only)
    - `:split`: if the data is from the train, dev, or test datasets
  """

  import Ecto.Changeset
  use Ecto.Schema

  schema "siqas" do
    field :context, :string
    field :question, :string
    field :answerA, :string
    field :answerB, :string
    field :answerC, :string
    field :label, :integer
    field :split, :string
  end

  def changeset(siqa, attrs \\ %{}) do
    siqa
    |> cast(attrs, [:context, :question, :answerA, :answerB, :answerC, :label, :split])
  end
end
