defmodule PropertyManagementSystem.Maintenance_requestsTest do
  use PropertyManagementSystem.DataCase

  alias PropertyManagementSystem.Maintenance_requests

  describe "maintenance_requests" do
    alias PropertyManagementSystem.Maintenance_requests.Maintenance_request

    import PropertyManagementSystem.Maintenance_requestsFixtures

    @invalid_attrs %{cost: nil, description: nil, request_date: nil, status: nil}

    test "list_maintenance_requests/0 returns all maintenance_requests" do
      maintenance_request = maintenance_request_fixture()
      assert Maintenance_requests.list_maintenance_requests() == [maintenance_request]
    end

    test "get_maintenance_request!/1 returns the maintenance_request with given id" do
      maintenance_request = maintenance_request_fixture()

      assert Maintenance_requests.get_maintenance_request!(maintenance_request.id) ==
               maintenance_request
    end

    test "create_maintenance_request/1 with valid data creates a maintenance_request" do
      valid_attrs = %{
        cost: 120.5,
        description: "some description",
        request_date: ~D[2023-08-08],
        status: "some status"
      }

      assert {:ok, %Maintenance_request{} = maintenance_request} =
               Maintenance_requests.create_maintenance_request(valid_attrs)

      assert maintenance_request.cost == 120.5
      assert maintenance_request.description == "some description"
      assert maintenance_request.request_date == ~D[2023-08-08]
      assert maintenance_request.status == "some status"
    end

    test "create_maintenance_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Maintenance_requests.create_maintenance_request(@invalid_attrs)
    end

    test "update_maintenance_request/2 with valid data updates the maintenance_request" do
      maintenance_request = maintenance_request_fixture()

      update_attrs = %{
        cost: 456.7,
        description: "some updated description",
        request_date: ~D[2023-08-09],
        status: "some updated status"
      }

      assert {:ok, %Maintenance_request{} = maintenance_request} =
               Maintenance_requests.update_maintenance_request(maintenance_request, update_attrs)

      assert maintenance_request.cost == 456.7
      assert maintenance_request.description == "some updated description"
      assert maintenance_request.request_date == ~D[2023-08-09]
      assert maintenance_request.status == "some updated status"
    end

    test "update_maintenance_request/2 with invalid data returns error changeset" do
      maintenance_request = maintenance_request_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Maintenance_requests.update_maintenance_request(
                 maintenance_request,
                 @invalid_attrs
               )

      assert maintenance_request ==
               Maintenance_requests.get_maintenance_request!(maintenance_request.id)
    end

    test "delete_maintenance_request/1 deletes the maintenance_request" do
      maintenance_request = maintenance_request_fixture()

      assert {:ok, %Maintenance_request{}} =
               Maintenance_requests.delete_maintenance_request(maintenance_request)

      assert_raise Ecto.NoResultsError, fn ->
        Maintenance_requests.get_maintenance_request!(maintenance_request.id)
      end
    end

    test "change_maintenance_request/1 returns a maintenance_request changeset" do
      maintenance_request = maintenance_request_fixture()

      assert %Ecto.Changeset{} =
               Maintenance_requests.change_maintenance_request(maintenance_request)
    end
  end
end
