defmodule SoftwareOptimization do
  @moduledoc """
  Documentation for SoftwareOptimization.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SoftwareOptimization.hello()
      :world

  """
  def hello do
    "Hello world"
  end

  def convert_tmp(a, val, a), do: val

  def convert_tmp(from, val, to) do
    IO.puts("Get #{from}:#{val}->#{to}")
    x = to_celsius(from, val)

    case to do
      :K -> x + 273.15
      :F -> val * (5 / 9) + 32
      :C -> x
      Other -> :error
    end
  end

  def to_celsius(from, val) do
    case from do
      :K -> val - 273.15
      :F -> (val - 32) / (5 / 9)
      :C -> val
      Other -> :error
    end
  end

  def pollyndrom(word) when is_binary(word) do
    x = String.reverse(word |> String.replace(" ", ""))
    x == word |> String.replace(" ", "")
  end

  def pollyndrom(_) do
    BadStructError
  end

  def rabbits(month) when is_integer(month) and month > 0 do
    fibbonaci(month)
  end

  def rabbits(w) do
    {BadStructError, IEx.Info.info(w)}
  end

  def fibbonaci(count) do
    fibbonaci(1, 1, count - 1)
  end

  def fibbonaci(_, cur, 0) do
    cur
  end

  def fibbonaci(prev, cur, count) do
    fibbonaci(cur, prev + cur, count - 1)
  end

  @spec read_csv(String.t()) :: list(map())
  def read_csv(path) do
    path
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> CSV.decode!()
    |> Enum.to_list
    |> tl
  end

  def csv action, path, row do
    read_csv(path)
    |> List.pop_at(row)
    |> elem(0)
    |> IO.inspect
    |> Enum.map(&to_float/1)
    |> IO.inspect
    |> csv_get_act(action)
  end

  defp to_float(x) when is_integer(x), do: x / 1
  defp to_float(x) when is_float(x), do: x
  defp to_float(x) do
    case Float.parse(x) do
      {num, _} -> num
      :error -> 0.0
    end
  end


  def csv_get_act([_ | data], :max), do: Enum.max data
  def csv_get_act([_ | data], :min), do: Enum.min data
  def csv_get_act([_ | data], :mnz), do: Enum.filter(data, &(&1 > 0)) |> Enum.min
  def csv_get_act([_ | data], :average), do: Enum.sum(data) |> (&(&1 / &2 )).(length data)
  def csv_get_act(l = [_ | data], :disp) do
    x = csv_get_act l, :average
    n = length data
    IO.puts "Length: #{n}"
    data
    |> List.foldl(0, &(&2 + :math.pow(&1 - x, 2)))
    |> :erlang.*(1 / (n - 1))

  end
  def csv_get_act([_ | data], _), do: {:error, data}

end
