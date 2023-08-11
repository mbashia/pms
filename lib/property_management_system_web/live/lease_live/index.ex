defmodule PropertyManagementSystemWeb.LeaseLive.Index do
  use PropertyManagementSystemWeb, :live_view

  alias PropertyManagementSystem.Leases
  alias PropertyManagementSystem.Leases.Lease

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :leases, list_leases())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Lease")
    |> assign(:lease, Leases.get_lease!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Lease")
    |> assign(:lease, %Lease{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Leases")
    |> assign(:lease, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    lease = Leases.get_lease!(id)
    {:ok, _} = Leases.delete_lease(lease)

    {:noreply, assign(socket, :leases, list_leases())}
  end

  defp list_leases do
    Leases.list_leases()
  end
end
