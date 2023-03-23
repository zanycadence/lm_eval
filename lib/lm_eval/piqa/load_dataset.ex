defmodule LmEval.PIQA.LoadDataset do
  @moduledoc """
  Helper functions to load the PIQA dataset into `LmEval.Repo`
  """

  alias LmEval.PIQA


  def load_piqa_dataset(data_dir, "tests") do
    tests_file_path = Path.join(data_dir, "tests.jsonl")
    File.stream!(tests_file_path)
    |> Stream.map(&Jason.decode!(&1, keys: :atoms))
    |> Stream.map(&Map.put(&1, :split, "test"))
    |> Stream.map(&PIQA.changeset(%PIQA{}, &1))
    |> Stream.map(&LmEval.Repo.insert/1)
    |> Stream.run()
  end

  def load_piqa_dataset(data_dir, split) do
    jsonl_file_path = Path.join(data_dir, "#{split}.jsonl")
    labels_file_path = Path.join(data_dir, "#{split}-labels.lst")

    jsonl_stream =
      File.stream!(jsonl_file_path)
      |> Stream.map(&Jason.decode!(&1, keys: :atoms))
      |> Stream.map(&Map.put(&1, :split, split))

    labels_stream =
      File.stream!(labels_file_path)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.to_integer/1)

    Stream.zip_with([jsonl_stream, labels_stream], fn [a, b] -> Map.put(a, :label, b) end)
    |> Stream.map(&PIQA.changeset(%PIQA{}, &1))
    |> Stream.map(&LmEval.Repo.insert/1)
    |> Stream.run()
  end
end
