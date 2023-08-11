defmodule PropertyManagementSystem.LeasesTest do
  use PropertyManagementSystem.DataCase

  alias PropertyManagementSystem.Leases

  describe "leases" do
    alias PropertyManagementSystem.Leases.Lease

    import PropertyManagementSystem.LeasesFixtures

    @invalid_attrs %{end_date: nil, rent_amount: nil, start_date: nil, status: nil}

    test "list_leases/0 returns all leases" do
      lease = lease_fixture()
      assert Leases.list_leases() == [lease]
    end

    test "get_lease!/1 returns the lease with given id" do
      lease = lease_fixture()
      assert Leases.get_lease!(lease.id) == lease
    end

    test "create_lease/1 with valid data creates a lease" do
      valid_attrs = %{
        end_date: ~D[2023-08-08],
        rent_amount: 120.5,
        start_date: ~D[2023-08-08],
        status: "some status"
      }

      assert {:ok, %Lease{} = lease} = Leases.create_lease(valid_attrs)
      assert lease.end_date == ~D[2023-08-08]
      assert lease.rent_amount == 120.5
      assert lease.start_date == ~D[2023-08-08]
      assert lease.status == "some status"
    end

    test "create_lease/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Leases.create_lease(@invalid_attrs)
    end

    test "update_lease/2 with valid data updates the lease" do
      lease = lease_fixture()

      update_attrs = %{
        end_date: ~D[2023-08-09],
        rent_amount: 456.7,
        start_date: ~D[2023-08-09],
        status: "some updated status"
      }

      assert {:ok, %Lease{} = lease} = Leases.update_lease(lease, update_attrs)
      assert lease.end_date == ~D[2023-08-09]
      assert lease.rent_amount == 456.7
      assert lease.start_date == ~D[2023-08-09]
      assert lease.status == "some updated status"
    end

    test "update_lease/2 with invalid data returns error changeset" do
      lease = lease_fixture()
      assert {:error, %Ecto.Changeset{}} = Leases.update_lease(lease, @invalid_attrs)
      assert lease == Leases.get_lease!(lease.id)
    end

    test "delete_lease/1 deletes the lease" do
      lease = lease_fixture()
      assert {:ok, %Lease{}} = Leases.delete_lease(lease)
      assert_raise Ecto.NoResultsError, fn -> Leases.get_lease!(lease.id) end
    end

    test "change_lease/1 returns a lease changeset" do
      lease = lease_fixture()
      assert %Ecto.Changeset{} = Leases.change_lease(lease)
    end
  end
end
