defmodule EasyPost.Parcel do
  import EasyPost.Helpers
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

  def create(params), do: @endpoint |> API.create(params) |> format_response

  def read(id), do: @endpoint |> API.read(id) |> format_response

  defp format_response({:error, reason}), do: {:error, reason}
  defp format_response({:ok, raw_parcel}) do
    parcel =
      raw_parcel
      |> into(__MODULE__)
      |> mode_field(:mode)
      |> date_field(:created_at)
      |> date_field(:updated_at)

    {:ok, parcel}
  end
end
