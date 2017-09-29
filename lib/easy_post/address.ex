defmodule EasyPost.Address do
  import EasyPost.Helpers
  alias EasyPost.API

  @endpoint "addresses"

  defstruct [
    id: nil,
    mode: :test,
    created_at: nil,
    updated_at: nil,

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
  ]

  @type t :: %__MODULE__{
    id: nil | String.t,
    mode: EasyPost.mode,
    created_at: DateTime.t,
    updated_at: DateTime.t,

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
  }

  def create(params, opts \\ []) do
    params = maybe_add_verification(params, opts)
    @endpoint |> API.create(params) |> format_response
  end

  def read(id), do: @endpoint |> API.read(id) |> format_response

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

  defp maybe_add_verification(params, opts) do
    verify = Keyword.get(opts, :verify, nil)
    strict = Keyword.get(opts, :strict, false)

    case {verify, strict} do
      {:zip4, false} -> [{"verify[]", "zip4"} | params]
      {:zip4, true} -> [{"verify_strict[]", "zip4"} | params]
      {:delivery, false} -> [{"verify[]", "delivery"} | params]
      {:delivery, true} -> [{"verify_strict[]", "delivery"} | params]
      _ -> params
    end
  end
end
