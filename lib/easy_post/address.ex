defmodule EasyPost.Address do
  import EasyPost.Helpers
  alias EasyPost.API

  @endpoint "addresses"

  defstruct [
    id: nil,
    created_at: nil,
    updated_at: nil,

    mode: :test,
    street1: "",
    street2: "",
    city: "",
    state: "",
    zip: "",
    country: "",
    residential: false,
    carrier_facility: nil,
    name: nil,
    company: nil,
    phone: "",
    email: "",
    federal_tax_id: nil,
    state_tax_id: nil,
    verifications: %{},
  ]

  @type t :: %__MODULE__{
    id: nil | String.t,
    mode: :test | :production,
    street1: String.t,
    street2: String.t,
    city: String.t,
    state: String.t,
    zip: String.t,
    country: String.t,
    residential: boolean,
    carrier_facility: nil | String.t,
    name: String.t,
    company: String.t,
    phone: String.t,
    email: String.t,

    created_at: DateTime.t,
    updated_at: DateTime.t
  }

  def create(params), do: @endpoint |> API.create(params)# |> format_response

  defp format_response({:error, reason}), do: {:error, reason}
  defp format_response({:ok, raw_address}) do
    address =
      raw_address
      |> into(__MODULE__)
      |> mode_field(:mode)
      |> date_field(:created_at)
      |> date_field(:updated_at)

    {:ok, address}
  end
end
