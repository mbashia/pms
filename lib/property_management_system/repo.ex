defmodule PropertyManagementSystem.Repo do
  use Ecto.Repo,
    otp_app: :property_management_system,
    adapter: Ecto.Adapters.MyXQL
end
