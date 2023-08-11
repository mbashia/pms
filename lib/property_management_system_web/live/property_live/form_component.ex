defmodule PropertyManagementSystemWeb.PropertyLive.FormComponent do
  use PropertyManagementSystemWeb, :live_component

  alias PropertyManagementSystem.Propertys

  @impl true
  def update(%{property: property} = assigns, socket) do
    changeset = Propertys.change_property(property)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"property" => property_params}, socket) do
    changeset =
      socket.assigns.property
      |> Propertys.change_property(property_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"property" => property_params}, socket) do

    save_property(socket, socket.assigns.action, property_params)
  end

  defp save_property(socket, :edit, property_params) do
    case Propertys.update_property(socket.assigns.property, property_params) do
      {:ok, _property} ->
        {:noreply,
         socket
         |> put_flash(:info, "Property updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_property(socket, :new, property_params) do
    property_params = Map.put(property_params, "user_id", socket.assigns.user.id)



    case Propertys.create_property(property_params) do
      {:ok, _property} ->
        {:noreply,
         socket
         |> put_flash(:info, "Property created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
