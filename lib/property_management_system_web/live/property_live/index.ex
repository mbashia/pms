defmodule PropertyManagementSystemWeb.PropertyLive.Index do
  use PropertyManagementSystemWeb, :live_view

  alias PropertyManagementSystem.Propertys
  alias PropertyManagementSystem.Propertys.Property
  alias PropertyManagementSystem.Accounts

  @impl true
  def mount(_params, session, socket) do
    IO.write("session starts here /n")
    IO.inspect(session)
    user = Accounts.get_user_by_session_token(session["user_token"])
 IO.inspect user
    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:propertys, list_propertys())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Property")
    |> assign(:property, Propertys.get_property!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Property")
    |> assign(:property, %Property{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Propertys")
    |> assign(:property, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    property = Propertys.get_property!(id)
    {:ok, _} = Propertys.delete_property(property)

    {:noreply, assign(socket, :propertys, list_propertys())}
  end

  defp list_propertys do
    Propertys.list_propertys()
  end
end
