defmodule CrossCommerceTestWeb.Store do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(
      fn ->
        %{
          numbers: initial_value,
          initial_value: initial_value,
          load_status: {:ok, %{message: "Wait: loading numbers", loading: true}}
        }
      end,
      name: __MODULE__
    )
  end

  # used only on test cases
  def stop_link() do
    Agent.stop(__MODULE__)
  end

  defp get(name_state) when is_atom(name_state) do
    Agent.get(__MODULE__, fn state ->
      Map.get(state, name_state)
    end)
  end

  defp put(name_state, callback) when is_atom(name_state) and is_function(callback) do
    Agent.update(__MODULE__, fn state ->
      callback.(state, name_state)
    end)
  end

  def get_numbers do
    get(:numbers)
  end

  def put_numbers(data) when is_list(data) do
    put(:numbers, fn state, name_state ->
      list = Map.get(state, name_state) ++ data
      Map.put(state, name_state, list)
    end)
  end

  def reset_numbers do
    Agent.update(__MODULE__, fn state ->
      Map.put(state, :numbers, Map.get(state, :initial_value))
    end)
  end

  def get_load_status do
    get(:load_status)
  end

  def put_load_status(data) when is_tuple(data) do
    put(:load_status, fn state, name_state ->
      Map.put(state, name_state, data)
    end)
  end
end
