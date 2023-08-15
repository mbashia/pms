defmodule PropertyManagementSystemWeb.HouseLive.Index do
  use PropertyManagementSystemWeb, :live_view

  alias PropertyManagementSystem.Houses
  alias PropertyManagementSystem.Houses.House
  alias PropertyManagementSystem.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:houses, list_houses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit House")
    |> assign(:house, Houses.get_house!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New House")
    |> assign(:house, %House{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Houses")
    |> assign(:house, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    house = Houses.get_house!(id)
    {:ok, _} = Houses.delete_house(house)

    {:noreply, assign(socket, :houses, list_houses())}
  end

  defp list_houses do
    Houses.list_houses()
  end
end
