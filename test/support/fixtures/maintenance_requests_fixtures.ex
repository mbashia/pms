defmodule PropertyManagementSystem.Maintenance_requestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PropertyManagementSystem.Maintenance_requests` context.
  """

  @doc """
  Generate a maintenance_request.
  """
  def maintenance_request_fixture(attrs \\ %{}) do
    {:ok, maintenance_request} =
      attrs
      |> Enum.into(%{
        cost: 120.5,
        description: "some description",
        request_date: ~D[2023-08-08],
        status: "some status"
      })
      |> PropertyManagementSystem.Maintenance_requests.create_maintenance_request()

    maintenance_request
  end
end
