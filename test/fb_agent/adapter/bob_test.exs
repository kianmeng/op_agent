defmodule FBAgent.Adapter.BobTest do
  use ExUnit.Case
  alias FBAgent.Adapter.Bob
  doctest FBAgent.Adapter.Bob

  describe "FBAgent.Adapter.Bob.fetch_tx/1" do

    setup do
      Tesla.Mock.mock fn
        _ -> File.read!("test/mocks/bob_fetch_tx.json") |> Jason.decode! |> Tesla.Mock.json
      end
      :ok
    end

    test "get tx" do
      {:ok, tx} = Bob.fetch_tx("98be5010028302399999bfba0612ee51ea272e7a0eb3b45b4b8bef85f5317633", api_key: "test")
      assert tx.txid == "98be5010028302399999bfba0612ee51ea272e7a0eb3b45b4b8bef85f5317633"
      assert tx.in |> length == 1
      assert tx.out |> length == 3
      assert tx.out |> List.first |> Map.get(:tape) |> Enum.at(1) |> Map.get(:cell) |> length == 5
    end
    
  end

end