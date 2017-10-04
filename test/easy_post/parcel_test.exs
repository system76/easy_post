defmodule EasyPost.ParcelTest do
  use ExUnit.Case, async: false

  alias EasyPost.Parcel

  @valid_params %{
    length: "12.0",
    width: "12.0",
    height: "12.0",
    weight: "16.0",
  }

  @valid_predefined_params %{
    predefined_package: "SmallFlatRateBox",
    weight: "16.0",
  }

  test "creating a new parcel" do
    {:ok, parcel} = Parcel.create(@valid_params)

    refute is_nil(parcel.id)
    assert parcel.created_at.__struct__ == DateTime
    assert parcel.updated_at.__struct__ == DateTime
    assert parcel == %Parcel{
      id: parcel.id,
      mode: :test,
      length: 12.0,
      width: 12.0,
      height: 12.0,
      predefined_package: nil,
      weight: 16.0,
      created_at: parcel.created_at,
      updated_at: parcel.updated_at,
    }
  end

  test "creating a new parcel from a predefined package" do
    {:ok, parcel} = Parcel.create(@valid_predefined_params)

    refute is_nil(parcel.id)
    assert parcel.created_at.__struct__ == DateTime
    assert parcel.updated_at.__struct__ == DateTime
    assert parcel == %Parcel{
      id: parcel.id,
      mode: :test,
      length: nil,
      width: nil,
      height: nil,
      predefined_package: "SmallFlatRateBox",
      weight: 16.0,
      created_at: parcel.created_at,
      updated_at: parcel.updated_at,
    }
  end

  test "retrieving an existing parcel" do
    {:ok, parcel} = Parcel.create(@valid_params)
    {:ok, parcel_copy} = Parcel.retrieve(parcel.id)

    assert parcel == parcel_copy
  end
end

