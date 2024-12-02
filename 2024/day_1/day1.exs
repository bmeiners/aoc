defmodule Day1 do
  def read_file(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
                line 
                |> String.split("   ", trim: true)
                |> Enum.map(&String.to_integer/1) 
                end )
  end
  def get_sum(lists) do
    list_1 = lists |> Enum.map(&List.first/1) |> Enum.sort
    list_2 = lists |> Enum.map(&List.last/1)  |> Enum.sort
    zipped_lists = Enum.zip(list_1,list_2)
    zipped_lists 
    |> Enum.map(fn({a,b}) -> abs(a-b) end)
    |> Enum.sum()
  end
  def get_similarity_score(lists) do
    list_1 = lists |> Enum.map(&List.first/1)
    list_2 = lists |> Enum.map(&List.last/1)
    list_1
    |> Enum.map( fn(x) -> list_2 
                      |> Enum.map(fn(y) -> if x == y, do: 1, else: 0 
                                  end)
                end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.zip(list_1)
    |> Enum.map(fn {a, b} -> a*b end)
    |> Enum.sum
  end
end

output = Day1.read_file("day1.txt") |> Day1.get_similarity_score
IO.puts(output)
