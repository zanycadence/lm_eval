defmodule LmEval.Repo.Boolq do
  @moduledoc """
  BoolQ is a benchmark for testing the ability of a language model to correctly answer a true/false question when given a passage from Wikipedia that is relevant to the question.

  Keys are as follows
  - `:answer`: boolean answer found in the training and dev datasets
  - `:passage`: a relevant passage from Wikipedia for answering the question
  - `:question`: a question with a true/false answer
  - `:title`: the title of the question
  - `:split`: whether it's from the train, dev, or test dataset split
  """

  import Ecto.Changeset
  use Ecto.Schema

  schema "boolqs" do
    field :answer, :boolean
    field :passage, :string
    field :question, :string
    field :title, :string
    field :split, :string
  end

  def changeset(boolq, attrs \\ %{}) do
    boolq
    |> cast(attrs, [:answer, :passage, :question, :title, :split])
    |> validate_required([:passage, :question, :title, :split])
  end
end
