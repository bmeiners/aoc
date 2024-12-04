defmodule Day3 do
  def part1(path) do
    contents = File.read!(path)
    Regex.scan(~r/mul\((\d+),(\d+)\)/, contents)
    |> Enum.map(&get_multiplies/1)
    |> Enum.sum
    |> IO.puts
  end
  def get_multiplies(vec) do
    [_, num1, num2] = vec
    String.to_integer(num1) * String.to_integer(num2)
  end
  def part2(path) do
    contents = File.read!(path)
    Regex.scan(~r/mul\((\d+)\,(\d+)\)|do\(\)|don\'t\(\)/, contents)
    |> rec_sum(true,0)
    |> IO.puts
  end
  def rec_sum(matches,switch,acc) do
    [match | rest] = matches
    case {match,length(rest),switch} do
      {["do()"],0,_} -> acc
      {["don't()"],0,_} -> acc 
      {_,0,false} -> acc
      {_,0,true} -> acc + get_multiplies(match)
      {["do()"],_,_} -> rec_sum(rest,true,acc)
      {["don't()"],_,_} -> rec_sum(rest,false,acc)
      {_,_,true} -> rec_sum(rest,true,acc + get_multiplies(match))
      {_,_,false} -> rec_sum(rest,false,acc)
    end
  end
end

Day3.part1("day3.txt")
Day3.part2("day3.txt")
