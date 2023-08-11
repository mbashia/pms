defmodule PropertyManagementSystem.HousesTest do
  use PropertyManagementSystem.DataCase

  alias PropertyManagementSystem.Houses

  describe "houses" do
    alias PropertyManagementSystem.Houses.House

    import PropertyManagementSystem.HousesFixtures

    @invalid_attrs %{
      date_occupied: nil,
      date_vacated: nil,
      description: nil,
      floor_number: nil,
      house_number: nil,
      rent_amount: nil,
      size: nil,
      status: nil
    }

    test "list_houses/0 returns all houses" do
      house = house_fixture()
      assert Houses.list_houses() == [house]
    end

    test "get_house!/1 returns the house with given id" do
      house = house_fixture()
      assert Houses.get_house!(house.id) == house
    end

    test "create_house/1 with valid data creates a house" do
      valid_attrs = %{
        date_occupied: ~D[2023-08-09],
        date_vacated: ~D[2023-08-09],
        description: "some description",
        floor_number: "some floor_number",
        house_number: "some house_number",
        rent_amount: 120.5,
        size: 120.5,
        status: "some status"
      }

      assert {:ok, %House{} = house} = Houses.create_house(valid_attrs)
      assert house.date_occupied == ~D[2023-08-09]
      assert house.date_vacated == ~D[2023-08-09]
      assert house.description == "some description"
      assert house.floor_number == "some floor_number"
      assert house.house_number == "some house_number"
      assert house.rent_amount == 120.5
      assert house.size == 120.5
      assert house.status == "some status"
    end

    test "create_house/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Houses.create_house(@invalid_attrs)
    end

    test "update_house/2 with valid data updates the house" do
      house = house_fixture()

      update_attrs = %{
        date_occupied: ~D[2023-08-10],
        date_vacated: ~D[2023-08-10],
        description: "some updated description",
        floor_number: "some updated floor_number",
        house_number: "some updated house_number",
        rent_amount: 456.7,
        size: 456.7,
        status: "some updated status"
      }

      assert {:ok, %House{} = house} = Houses.update_house(house, update_attrs)
      assert house.date_occupied == ~D[2023-08-10]
      assert house.date_vacated == ~D[2023-08-10]
      assert house.description == "some updated description"
      assert house.floor_number == "some updated floor_number"
      assert house.house_number == "some updated house_number"
      assert house.rent_amount == 456.7
      assert house.size == 456.7
      assert house.status == "some updated status"
    end

    test "update_house/2 with invalid data returns error changeset" do
      house = house_fixture()
      assert {:error, %Ecto.Changeset{}} = Houses.update_house(house, @invalid_attrs)
      assert house == Houses.get_house!(house.id)
    end

    test "delete_house/1 deletes the house" do
      house = house_fixture()
      assert {:ok, %House{}} = Houses.delete_house(house)
      assert_raise Ecto.NoResultsError, fn -> Houses.get_house!(house.id) end
    end

    test "change_house/1 returns a house changeset" do
      house = house_fixture()
      assert %Ecto.Changeset{} = Houses.change_house(house)
    end
  end
end
