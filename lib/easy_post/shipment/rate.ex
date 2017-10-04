defmodule EasyPost.Shipment.Rate do
  defstruct [
    id: nil,
    mode: :test,
    created_at: nil,
    updated_at: nil,

    service: nil,
    carrier: nil,
    carrier_account_id: nil,
    shipment_id: nil,
    rate: nil,
    currency: nil,
    retail_rate: nil,
    retail_currency: nil,
    list_rate: nil,
    list_currency: nil,
    delivery_days: nil,
    delivery_date: nil,
    delivery_date_guaranteed: false,
  ]

  @type t :: %__MODULE__{
    id: nil | String.t,
    mode: EasyPost.mode,
    created_at: DateTime.t,
    updated_at: DateTime.t,

    service: String.t,
    carrier: String.t,
    carrier_account_id: String.t,
    shipment_id: String.t,
    rate: String.t, # TODO: Decimal.t
    currency: nil | String.t,
    retail_rate: String.t, # TODO: Decimal.t
    retail_currency: String.t,
    list_rate: String.t, # TODO: Decimal.t
    list_currency: String.t,
    delivery_days: non_neg_integer,
    delivery_date: DateTime.t,
    delivery_date_guaranteed: boolean,
  }
end
