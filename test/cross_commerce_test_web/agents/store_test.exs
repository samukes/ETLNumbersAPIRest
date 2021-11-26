defmodule StoreTest do
  use ExUnit.Case

  describe "CrossCommerceTestWeb.Store" do
    test "Agent store working well" do
      CrossCommerceTestWeb.Store.stop_link()

      {status, pid} = CrossCommerceTestWeb.Store.start_link([])

      assert status == :ok
      assert not is_nil(pid) == true

      result = CrossCommerceTestWeb.Store.put_numbers([1])

      assert result == :ok

      get_list = CrossCommerceTestWeb.Store.get_numbers()

      assert get_list == [1]

      CrossCommerceTestWeb.Store.put_numbers([2, 3, 4, 5])
      put_list = CrossCommerceTestWeb.Store.get_numbers()

      assert put_list == [1, 2, 3, 4, 5]

      CrossCommerceTestWeb.Store.reset_numbers()
      reset_list = CrossCommerceTestWeb.Store.get_numbers()

      assert reset_list == []
    end
  end
end
