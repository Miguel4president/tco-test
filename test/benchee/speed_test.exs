require MyList

lists = %{
  "Small (100 K)"   => Enum.to_list(1..100_000),
  "Medium (1 M)"    => Enum.to_list(1..1_000_000),
  "Big (10 M)"      => Enum.to_list(1..10_000_000),
}

Benchee.run(%{
  "double"            => fn(list) -> MyList.double(list) end,
  "double_tco"        => fn(list) -> MyList.double_tco(list) end,
  "double_tco_order"  => fn(list) -> MyList.double_tco_order(list) end,
  "Enum.map"          => fn(list) -> Enum.map(list, fn(x) -> x * 2 end) end
},
inputs: lists,
time: 20,
formatters: [
  &Benchee.Formatters.CSV.output/1,
  &Benchee.Formatters.Console.output/1
],
formatter_options: [csv: [file: "my.csv"]]
)
