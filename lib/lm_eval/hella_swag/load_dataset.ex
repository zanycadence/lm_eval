defmodule LmEval.HellaSwag.LoadDataset do
  @moduledoc """
  Helper functions to load the hellaswag dataset into our `LmEval.Repo`
  """
  alias LmEval.HellaSwag

  def load_hellaswag_data(data_dir) do
    ["hellaswag_train.jsonl", "hellaswag_test.jsonl", "hellaswag_val.jsonl"]
    |> Enum.map(&load_hellaswag_file("#{data_dir}/#{&1}"))
  end

  defp load_hellaswag_file(file_path) do
    File.stream!(file_path)
    |> Stream.map(&Jason.decode!(&1, keys: :atoms))
    |> Stream.map(&HellaSwag.changeset(%HellaSwag{}, &1))
    |> Stream.map(&LmEval.Repo.insert/1)
    |> Stream.run()
  end
end
