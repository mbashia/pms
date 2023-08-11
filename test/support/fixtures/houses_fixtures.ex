defmodule PropertyManagementSystem.HousesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PropertyManagementSystem.Houses` context.
  """

  @doc """
  Generate a house.
  """
  def house_fixture(attrs \\ %{}) do
    {:ok, house} =
      attrs
      |> Enum.into(%{
        date_occupied: ~D[2023-08-09],
        date_vacated: ~D[2023-08-09],
        description: "some description",
        floor_number: "some floor_number",
        house_number: "some house_number",
        rent_amount: 120.5,
        size: 120.5,
        status: "some status"
      })
      |> PropertyManagementSystem.Houses.create_house()

    house
  end
end
