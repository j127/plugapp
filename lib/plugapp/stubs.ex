defmodule Plugapp.Stubs do
  def portfolio_entries do
    for x <- 0..8, do: %{name: "project #{x}", image: "https://placekitten.com/40#{x}/30#{x}"}
  end

  def submit_contact(params) do
    IO.inspect(params, label: "submitted contact")
  end
end
