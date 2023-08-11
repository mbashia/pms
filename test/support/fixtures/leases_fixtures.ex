defmodule PropertyManagementSystem.LeasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PropertyManagementSystem.Leases` context.
  """

  @doc """
  Generate a lease.
  """
  def lease_fixture(attrs \\ %{}) do
    {:ok, lease} =
      attrs
      |> Enum.into(%{
        end_date: ~D[2023-08-08],
        rent_amount: 120.5,
        start_date: ~D[2023-08-08],
        status: "some status"
      })
      |> PropertyManagementSystem.Leases.create_lease()

    lease
  end
end
