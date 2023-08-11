defmodule PropertyManagementSystemWeb.LeaseLiveTest do
  use PropertyManagementSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import PropertyManagementSystem.LeasesFixtures

  @create_attrs %{
    end_date: %{day: 8, month: 8, year: 2023},
    rent_amount: 120.5,
    start_date: %{day: 8, month: 8, year: 2023},
    status: "some status"
  }
  @update_attrs %{
    end_date: %{day: 9, month: 8, year: 2023},
    rent_amount: 456.7,
    start_date: %{day: 9, month: 8, year: 2023},
    status: "some updated status"
  }
  @invalid_attrs %{
    end_date: %{day: 30, month: 2, year: 2023},
    rent_amount: nil,
    start_date: %{day: 30, month: 2, year: 2023},
    status: nil
  }

  defp create_lease(_) do
    lease = lease_fixture()
    %{lease: lease}
  end

  describe "Index" do
    setup [:create_lease]

    test "lists all leases", %{conn: conn, lease: lease} do
      {:ok, _index_live, html} = live(conn, Routes.lease_index_path(conn, :index))

      assert html =~ "Listing Leases"
      assert html =~ lease.status
    end

    test "saves new lease", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.lease_index_path(conn, :index))

      assert index_live |> element("a", "New Lease") |> render_click() =~
               "New Lease"

      assert_patch(index_live, Routes.lease_index_path(conn, :new))

      assert index_live
             |> form("#lease-form", lease: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#lease-form", lease: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lease_index_path(conn, :index))

      assert html =~ "Lease created successfully"
      assert html =~ "some status"
    end

    test "updates lease in listing", %{conn: conn, lease: lease} do
      {:ok, index_live, _html} = live(conn, Routes.lease_index_path(conn, :index))

      assert index_live |> element("#lease-#{lease.id} a", "Edit") |> render_click() =~
               "Edit Lease"

      assert_patch(index_live, Routes.lease_index_path(conn, :edit, lease))

      assert index_live
             |> form("#lease-form", lease: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#lease-form", lease: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lease_index_path(conn, :index))

      assert html =~ "Lease updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes lease in listing", %{conn: conn, lease: lease} do
      {:ok, index_live, _html} = live(conn, Routes.lease_index_path(conn, :index))

      assert index_live |> element("#lease-#{lease.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#lease-#{lease.id}")
    end
  end

  describe "Show" do
    setup [:create_lease]

    test "displays lease", %{conn: conn, lease: lease} do
      {:ok, _show_live, html} = live(conn, Routes.lease_show_path(conn, :show, lease))

      assert html =~ "Show Lease"
      assert html =~ lease.status
    end

    test "updates lease within modal", %{conn: conn, lease: lease} do
      {:ok, show_live, _html} = live(conn, Routes.lease_show_path(conn, :show, lease))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Lease"

      assert_patch(show_live, Routes.lease_show_path(conn, :edit, lease))

      assert show_live
             |> form("#lease-form", lease: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#lease-form", lease: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.lease_show_path(conn, :show, lease))

      assert html =~ "Lease updated successfully"
      assert html =~ "some updated status"
    end
  end
end
