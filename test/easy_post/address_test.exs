defmodule EasyPost.AddressTest do
  use ExUnit.Case, async: false

  alias EasyPost.Address

  @valid_params [
    {"address[name]", "Carl Richell"},
    {"address[company]", "System76"},
    {"address[street1]", "1600 Champa"},
    {"address[street2]", "Suite 360"},
    {"address[city]", "Denver"},
    {"address[state]", "CO"},
    {"address[zip]", "80202"},
    {"address[country]", "US"},
  ]

  test "creating a new address" do
    {:ok, address} = Address.create(@valid_params)

    refute is_nil(address.id)
    assert address.created_at.__struct__ == DateTime
    assert address.updated_at.__struct__ == DateTime
    assert address == %Address{
      id: address.id,
      mode: :test,
      created_at: address.created_at,
      updated_at: address.updated_at,
      street1: "1600 Champa",
      street2: "Suite 360",
      city: "Denver",
      state: "CO",
      zip: "80202",
      country: "US",
      residential: nil,
      carrier_facility: nil,
      name: "Carl Richell",
      company: "System76",
      phone: nil,
      email: nil,
      federal_tax_id: nil,
      state_tax_id: nil,
    }
  end

  test "retrieving an existing address" do
    {:ok, address} = Address.create(@valid_params)
    {:ok, address_copy} = Address.read(address.id)

    assert address == address_copy
  end

  @tag :skip
  test "verifying an address"
end
