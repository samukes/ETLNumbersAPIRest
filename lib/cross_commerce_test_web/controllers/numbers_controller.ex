defmodule CrossCommerceTestWeb.NumbersController do
  use CrossCommerceTestWeb, :controller
  alias CrossCommerceTestWeb.Store

  def show(conn, _params) do
    {_, status} = Store.get_load_status()

    render(conn, "show.json", %{
      data: %{status: status, numbers: Store.get_numbers()}
    })
  end
end
