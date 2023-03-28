defmodule LmEval.Boolq.LoadDataset do
  @moduledoc """
  Helper functions to load the boolq dataset into the `LmEval.Repo`
  """

  alias LmEval.Repo.Boolq

  def load_boolq_data(data_dir) do
    [{"dev.jsonl", "dev"}, {"train.jsonl", "train"}, {"test.jsonl", "test"}]
    |> Enum.map(&load_boolq_file(data_dir, &1))
  end

  defp load_boolq_file(data_dir, {file_path, split}) do
    Path.join(data_dir, file_path)
    |> File.stream!()
    |> Stream.map(&Jason.decode!(&1, keys: :atoms))
    |> Stream.map(&Map.put(&1, :split, split))
    |> Stream.map(&Boolq.changeset(%Boolq{}, &1))
    |> Stream.map(&LmEval.Repo.insert/1)
    |> Stream.run()
  end
end
