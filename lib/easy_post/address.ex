defmodule EasyPost.Address do
  alias EasyPost.{API, Error}

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
    verifications: %{},
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
    verifications: %{
      optional(:zip4) => verification,
      optional(:delivery) => verification,
    },
  }

  @type verification :: %{
    success: boolean,
    details: %{
      latitude: float,
      longitude: float,
      time_zone: Calendar.time_zone,
    },
    errors: [Error.field_error],
  }

  def create(params, opts \\ []) do
    params = %{address: params} |> maybe_add_verification(opts)
    @endpoint |> API.post(params) |> API.format_response()
  end

  def retrieve(id) do
    "#{@endpoint}/#{id}" |> API.get() |> API.format_response()
  end

  defp maybe_add_verification(params, opts) do
    verify = Keyword.get(opts, :verify, nil)
    strict = Keyword.get(opts, :strict, false)

    case {verify, strict} do
      {:zip4, false}     -> Map.put(params, :verify,        ["zip4"])
      {:zip4, true}      -> Map.put(params, :verify_strict, ["zip4"])
      {:delivery, false} -> Map.put(params, :verify,        ["delivery"])
      {:delivery, true}  -> Map.put(params, :verify_strict, ["delivery"])
      _                  -> params
    end
  end
end
