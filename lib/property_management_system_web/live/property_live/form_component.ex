defmodule PropertyManagementSystemWeb.PropertyLive.FormComponent do
  use PropertyManagementSystemWeb, :live_component

  alias PropertyManagementSystem.Propertys

  @impl true
  def update(%{property: property} = assigns, socket) do

    changeset = Propertys.change_property(property)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:image, accept: ~w(.jpg .png .jpeg), max_entries: 1)
   }


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
    uploaded_files =
    consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
      dest = Path.join([:code.priv_dir(:property_management_system), "static", "uploads", Path.basename(path)])

      # The `static/uploads` directory must exist for `File.cp!/2`
      # and MyAppWeb.static_paths/0 should contain uploads to work,.
      File.cp!(path, dest)
      {:ok, "/uploads/" <> Path.basename(dest)}
    end)

  {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

  property_params = Map.put(property_params, "image", List.first(uploaded_files))

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
