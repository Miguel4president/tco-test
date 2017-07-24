defmodule MyList do
  def double([]), do: []
 
  def double([head | tail]) do
    [head * 2 | double(tail)]
  end

# This benefits from tail call optimization
# a_list = [1,2,3,4]
# Next step is take a measurement
# Maybe even write a blog post
  def double_tco([], accumulator), do: Enum.reverse(accumulator)

  def double_tco([head | tail], accumulator) do
    double_tco(tail, [head * 2 | accumulator])
  end

  def double_tco(list) do
    double_tco(list, [])
  end


# This is the same as double_tco
# The only dif is that the base case is tested last
# This way the most commonly hit definition is first
  def double_tco_order([head | tail], accumulator) do
    double_tco_order(tail, [head * 2 | accumulator])
  end
  
  def double_tco_order([], accumulator), do: Enum.reverse(accumulator)

  def double_tco_order(list) do
    double_tco_order(list, [])
  end


# This will use the elixir default implementation
# Assumed to be tail call optimized, I want to verify
# that it makes a difference
  def enum_double(list) do
    Enum.map(list, fn(x) -> x * 2 end)
  end

# Some testing around sum also
# Didn't see a significant memory difference above,
# in fact the "better" double used more memory
  def sum([]), do: 0
 
  def sum([head | tail]) do
    head + sum(tail)
  end


# tail call optimized
  def better_sum([], accumulator), do: accumulator
 
  def better_sum([head | tail], accumulator) do
    better_sum(tail, head + accumulator)
  end

  def better_sum(list) do
    better_sum(list, 0)
  end

end

# :observer.start()
