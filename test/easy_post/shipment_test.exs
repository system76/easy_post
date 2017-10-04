defmodule EasyPost.ShipmentTest do
  use ExUnit.Case, async: false

  alias EasyPost.{Address, Parcel, Shipment}

  @from_address_params %{
    name: "Carl Richell",
    company: "System76",
    street1: "1600 Champa",
    street2: "Suite 360",
    city: "Denver",
    state: "CO",
    zip: "80202",
    country: "US",
  }

  @to_address_params %{
    name: "Carl Richell",
    company: "System76",
    street1: "1600 Champa",
    street2: "Suite 360",
    city: "Denver",
    state: "CO",
    zip: "80202",
    country: "US",
  }

  @parcel_params %{
    predefined_package: "SmallFlatRateBox",
    weight: "16.0",
  }

  describe "creating a new shipment" do
    setup do
      {:ok, from_address} = Address.create(@from_address_params)
      {:ok, to_address} = Address.create(@to_address_params)
      {:ok, parcel} = Parcel.create(@parcel_params)

      {:ok, from_address: from_address, to_address: to_address, parcel: parcel}
    end

    test "using EasyPost resorces", %{
      from_address: from_address,
      to_address: to_address,
      parcel: parcel
    } do
      {:ok, shipment} = Shipment.create(%{
        from_address: from_address,
        to_address: to_address,
        parcel: parcel,
      })

      refute is_nil(shipment.id)
    end

    test "using ID strings", %{
      from_address: from_address,
      to_address: to_address,
      parcel: parcel
    } do
      {:ok, shipment} = Shipment.create(%{
        from_address: from_address.id,
        to_address: to_address.id,
        parcel: parcel.id,
      })

      refute is_nil(shipment.id)
    end

    test "using embedded parameters" do
      {:ok, shipment} = Shipment.create(%{
        from_address: @from_address_params,
        to_address: @to_address_params,
        parcel: @parcel_params,
      })

      refute is_nil(shipment.id)
    end
  end

  @tag :skip
  test "retrieving a list of shipments"

  test "retrieving a shipment" do
    {:ok, shipment} = Shipment.create(%{
      from_address: @from_address_params,
      to_address: @to_address_params,
      parcel: @parcel_params,
    })

    {:ok, shipment_copy} = Shipment.retrieve(shipment.id)

    assert shipment == shipment_copy
  end

  @tag :skip
  test "buying a shipment"

  @tag :skip
  test "converting the label format of a shipment"
end
