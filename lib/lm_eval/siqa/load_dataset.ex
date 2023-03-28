defmodule LmEval.SIQA.LoadDataset do
  @moduledoc """
  Helper functions to load the SIQA dataset into `LmEval.Repo`
  """

  alias LmEval.Repo.SIQA

  def load_siqa_dataset(data_dir, "test") do
    tests_file_path = Path.join(data_dir, "/socialiqa-test/socialiqa.jsonl")
    File.stream!(tests_file_path)
    |> Stream.map(&Jason.decode!(&1, keys: :atoms))
    |> Stream.map(&Map.put(&1, :split, "test"))
    |> Stream.map(&SIQA.changeset(%SIQA{}, &1))
    |> Stream.map(&LmEval.Repo.insert/1)
    |> Stream.run()
  end

  def load_siqa_dataset(data_dir, split) do
    jsonl_file_path = Path.join(data_dir, "/socialiqa-train-dev/#{split}.jsonl")
    labels_file_path = Path.join(data_dir, "/socialiqa-train-dev/#{split}-labels.lst")

    jsonl_stream =
      File.stream!(jsonl_file_path)
      |> Stream.map(&Jason.decode!(&1, keys: :atoms))
      |> Stream.map(&Map.put(&1, :split, split))

    labels_stream =
      File.stream!(labels_file_path)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.to_integer/1)

      Stream.zip_with([jsonl_stream, labels_stream], fn [a, b] -> Map.put(a, :label, b) end)
      |> Stream.map(&SIQA.changeset(%SIQA{}, &1))
      |> Stream.map(&LmEval.Repo.insert/1)
      |> Stream.run()
  end
end
