defmodule LmEval.Arc.LoadDataset do
  @moduledoc """
  Helper functions to load the ARC dataset into the `LmEval.Repo`
  """

  alias LmEval.Repo.Arc

  def load_arc_easy_data(data_dir) do
    data_dir = Path.join(data_dir, "ARC-Easy")
    [{"ARC-Easy-Train.jsonl", "train"}, {"ARC-Easy-Dev.jsonl", "dev"}, {"ARC-Easy-Test.jsonl", "test"}]
    |> Enum.map(&load_arc_file(data_dir, &1, "easy"))
  end

  def load_arc_challenge_data(data_dir) do
    data_dir = Path.join(data_dir, "ARC-Challenge")
    [{"ARC-Challenge-Train.jsonl", "train"}, {"ARC-Challenge-Dev.jsonl", "dev"}, {"ARC-Challenge-Test.jsonl", "test"}]
    |> Enum.map(&load_arc_file(data_dir, &1, "challenge"))
  end

  defp load_arc_file(data_dir, {file_path, split}, challenge_level) do
    Path.join(data_dir, file_path)
    |> File.stream!()
    |> Stream.map(&Jason.decode!(&1, keys: :atoms))
    |> Stream.map(&restructure_map(&1, split, challenge_level))
    |> Stream.map(&Arc.changeset(%Arc{}, &1))
    |> Stream.map(&LmEval.Repo.insert/1)
    |> Stream.run()
  end

  defp restructure_map(map, split, challenge_level) do
    %{
      answerKey: map.answerKey,
      ref_id: map.id,
      question_stem: map.question.stem,
      question_choices: map.question.choices,
      split: split,
      difficulty: challenge_level
    }
  end
end
