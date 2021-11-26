defmodule CrossCommerceTestWeb.NumbersTask do
  use Task
  alias CrossCommerceTestWeb.Store
  alias CrossCommerceTestWeb.MergeSort

  def start_link(_arg) do
    Task.start_link(__MODULE__, :run, [])
  end

  def run do
    load_data()
  end

  defp load_data do
    case HTTPoison.get("http://challenge.dienekes.com.br/api/numbers?page=1") do
      {:ok, %{body: body}} ->
        {:ok, body} = Poison.decode(body)
        Store.put_numbers(Enum.to_list(body["numbers"]))
        load_data(2)

      {:error, error} ->
        Store.put_load_status({:error, %{message: error, loading: false}})
    end
  end

  defp load_data(page) do
    case HTTPoison.get("http://challenge.dienekes.com.br/api/numbers?page=#{page}") do
      {:ok, %{body: body}} ->
        {:ok, body} = Poison.decode(body)

        case body do
          %{"error" => error} ->
            case error do
              "Simulated internal error" ->
                sort_numbers()

                Store.put_load_status(
                  {:ok, %{message: error, loaded_pages_at: page, loading: false}}
                )

              _ ->
                sort_numbers()

                Store.put_load_status(
                  {:error, %{message: "Error on application", loading: false}}
                )
            end

          %{"numbers" => numbers} ->
            case Enum.to_list(numbers) do
              [] ->
                sort_numbers()
                Store.put_load_status({:ok, %{result: "Loaded data", loading: false}})

              numbers ->
                Store.put_numbers(Enum.to_list(numbers))
                load_data(page + 1)
            end
        end

      {:error, error} ->
        sort_numbers()
        Store.put_load_status({:error, %{message: error, loading: false}})
    end
  end

  defp sort_numbers do
    store_numbers = MergeSort.sort(Store.get_numbers())
    Store.reset_numbers()
    Store.put_numbers(store_numbers)
  end
end
