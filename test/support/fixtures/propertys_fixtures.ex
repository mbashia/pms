defmodule PropertyManagementSystem.PropertysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PropertyManagementSystem.Propertys` context.
  """

  @doc """
  Generate a property.
  """
  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(%{
        address: "some address",
        description: "some description",
        name: "some name",
        size: "some size",
        status: "some status",
        type: "some type"
      })
      |> PropertyManagementSystem.Propertys.create_property()

    property
  end
end
