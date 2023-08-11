defmodule PropertyManagementSystemWeb.HouseLiveTest do
  use PropertyManagementSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import PropertyManagementSystem.HousesFixtures

  @create_attrs %{
    date_occupied: %{day: 9, month: 8, year: 2023},
    date_vacated: %{day: 9, month: 8, year: 2023},
    description: "some description",
    floor_number: "some floor_number",
    house_number: "some house_number",
    rent_amount: 120.5,
    size: 120.5,
    status: "some status"
  }
  @update_attrs %{
    date_occupied: %{day: 10, month: 8, year: 2023},
    date_vacated: %{day: 10, month: 8, year: 2023},
    description: "some updated description",
    floor_number: "some updated floor_number",
    house_number: "some updated house_number",
    rent_amount: 456.7,
    size: 456.7,
    status: "some updated status"
  }
  @invalid_attrs %{
    date_occupied: %{day: 30, month: 2, year: 2023},
    date_vacated: %{day: 30, month: 2, year: 2023},
    description: nil,
    floor_number: nil,
    house_number: nil,
    rent_amount: nil,
    size: nil,
    status: nil
  }

  defp create_house(_) do
    house = house_fixture()
    %{house: house}
  end

  describe "Index" do
    setup [:create_house]

    test "lists all houses", %{conn: conn, house: house} do
      {:ok, _index_live, html} = live(conn, Routes.house_index_path(conn, :index))

      assert html =~ "Listing Houses"
      assert html =~ house.description
    end

    test "saves new house", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.house_index_path(conn, :index))

      assert index_live |> element("a", "New House") |> render_click() =~
               "New House"

      assert_patch(index_live, Routes.house_index_path(conn, :new))

      assert index_live
             |> form("#house-form", house: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#house-form", house: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.house_index_path(conn, :index))

      assert html =~ "House created successfully"
      assert html =~ "some description"
    end

    test "updates house in listing", %{conn: conn, house: house} do
      {:ok, index_live, _html} = live(conn, Routes.house_index_path(conn, :index))

      assert index_live |> element("#house-#{house.id} a", "Edit") |> render_click() =~
               "Edit House"

      assert_patch(index_live, Routes.house_index_path(conn, :edit, house))

      assert index_live
             |> form("#house-form", house: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#house-form", house: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.house_index_path(conn, :index))

      assert html =~ "House updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes house in listing", %{conn: conn, house: house} do
      {:ok, index_live, _html} = live(conn, Routes.house_index_path(conn, :index))

      assert index_live |> element("#house-#{house.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#house-#{house.id}")
    end
  end

  describe "Show" do
    setup [:create_house]

    test "displays house", %{conn: conn, house: house} do
      {:ok, _show_live, html} = live(conn, Routes.house_show_path(conn, :show, house))

      assert html =~ "Show House"
      assert html =~ house.description
    end

    test "updates house within modal", %{conn: conn, house: house} do
      {:ok, show_live, _html} = live(conn, Routes.house_show_path(conn, :show, house))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit House"

      assert_patch(show_live, Routes.house_show_path(conn, :edit, house))

      assert show_live
             |> form("#house-form", house: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#house-form", house: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.house_show_path(conn, :show, house))

      assert html =~ "House updated successfully"
      assert html =~ "some updated description"
    end
  end
end
