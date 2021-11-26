defmodule CrossCommerceTestWeb.NumbersView do
  use CrossCommerceTestWeb, :view

  def render("show.json", params) do
    params.data
  end
end
