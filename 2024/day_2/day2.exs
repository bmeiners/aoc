 defmodule Day2 do
   def read_file(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
               line
               |> String.split(" ", trim: true)
               |> Enum.map(&String.to_integer/1)
               end )
    end
   def rec_subtract(vec,acc) do
     [a,b|tail] = vec
     if length(tail) == 0, 
       do: [b-a|acc], 
       else: rec_subtract([b|tail], [b - a | acc])
   end
   def is_safe(vec) do
     test_1 = vec
              |> Enum.all?(fn(x) -> abs(x) <= 3 end)
     test_2 = vec
              |> Enum.all?(fn(x) -> x > 0 end)
     test_3 = vec |> Enum.all?(fn(x) -> x < 0 end)
     test_1 and (test_2 or test_3)
   end
   def get_sum(vec) do
    vec |> Enum.map(fn x -> if x, do: 1, else: 0 end) |> Enum.sum
   end
   def run_numbers(numbers) do
    numbers
    |> Enum.map(fn line -> line 
                          |> rec_subtract([])
                          |> is_safe
                end)
   end 
   def generate_subsets(vec) do 
     vec |> Enum.map(fn x -> List.delete(vec, x) end) 
   end 
   def run_subset(numbers) do
     numbers
     |> Enum.map(&generate_subsets/1)
     |> Enum.map(fn line -> line |> run_numbers end)
     |> Enum.map(fn x -> x |> Enum.any? end) 
   end 
end

Day2.read_file("day2.txt")
  |> Day2.run_numbers
  |> Day2.get_sum
  |> IO.puts
            
Day2.read_file("day2.txt")
            |> Day2.run_subset
            |> IO.inspect(charlist: :as_chars)
 #|> Day2.get_sum
 #|> IO.puts
