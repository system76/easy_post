defmodule EasyPost.Parcel do
  alias EasyPost.API

  @endpoint "parcels"

  defstruct [
    id: nil,
    mode: :test,
    created_at: nil,
    updated_at: nil,

    length: 0, # in inches
    width: 0, # in inches
    height: 0, # in inches
    predefined_package: nil,
    weight: 0, # in ounces
  ]

  @type t :: %__MODULE__{
    id: nil | String.t,
    mode: EasyPost.mode,
    created_at: DateTime.t,
    updated_at: DateTime.t,

    length: EasyPost.inches,
    width: EasyPost.inches,
    height: EasyPost.inches,
    predefined_package: String.t,
    weight: EasyPost.ounces,
  }

  def create(params) do
    @endpoint |> API.post(%{parcel: params}) |> API.format_response()
  end

  def retrieve(id) do
    "#{@endpoint}/#{id}" |> API.get() |> API.format_response()
  end
end
