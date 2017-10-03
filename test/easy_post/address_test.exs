defmodule EasyPost.AddressTest do
  use ExUnit.Case, async: false

  alias EasyPost.{Address, Error}

  @valid_params %{
    name: "Carl Richell",
    company: "System76",
    street1: "1600 Champa",
    street2: "Suite 360",
    city: "Denver",
    state: "CO",
    zip: "80202",
    country: "US",
  }

  @invalid_params %{@valid_params | street1: "123 Fake St."}

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

  describe "verifying an address" do
    test "with zip4" do
      {:ok, address} = Address.create(@valid_params, verify: :zip4)

      assert address.street1 == "1600 Champa"
      assert address.zip == "80202-2709"
    end

    test "with delivery" do
      {:ok, address} = Address.create(@valid_params, verify: :delivery)

      assert address.street1 == "1600 CHAMPA ST STE 360"
      assert address.zip == "80202-2709"
    end

    test "fails with an error in strict mode" do
      {:error, error} = Address.create(@invalid_params, verify: :delivery, strict: true)

      assert match?(error, %Error{})
      assert error.code == "ADDRESS.VERIFY.FAILURE"
    end

    test "populates the verifications object" do
      {:ok, address} = Address.create(@valid_params, verify: :delivery)

    @tag :skip
    test "populates the verifications object"
  end
end
