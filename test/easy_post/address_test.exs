defmodule EasyPost.AddressTest do
  use ExUnit.Case, async: false

  alias EasyPost.Address

  @valid_address_params [
    {"verify_strict[]", "delivery"},
    {"address[name]", "Carl Richell"},
    {"address[company]", "System76"},
    {"address[street1]", "1600 Champa St."},
    {"address[street2]", "Suite 360"},
    {"address[city]", "Denver"},
    {"address[state]", "CO"},
    {"address[zip]", "80202"},
    {"address[country]", "US"},
  ]

  test "creating a new address" do
    {:ok, address} = Address.create(@valid_address_params)

    refute address
    assert address.mode == :test
    assert address.zip == "80202-2709"
  end

  test "fetching an existing address"

  test "verifying an address"
end
