defmodule EasyPost.ParcelTest do
  use ExUnit.Case, async: false

  alias EasyPost.Parcel

  @valid_params [
    {"parcel[length]", "12.0"},
    {"parcel[width]", "12.0"},
    {"parcel[height]", "12.0"},
    {"parcel[weight]", "16.0"},
  ]

  test "creating a new parcel" do
    {:ok, parcel} = Parcel.create(@valid_params)

    assert parcel.mode == :test
  end

  @tag :skip
  test "creating a new parcel from a predefined package"

  test "retrieving an existing parcel" do
    {:ok, parcel} = Parcel.create(@valid_params)
    {:ok, parcel_copy} = Parcel.read(parcel.id)

    assert parcel == parcel_copy
  end
end

