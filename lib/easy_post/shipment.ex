defmodule EasyPost.Shipment do
  alias EasyPost.{API, Address, Parcel, Shipment}

  @endpoint "shipments"

  defstruct [
    id: nil,
    mode: :test,
    created_at: nil,
    updated_at: nil,
    reference: nil,

    to_address: nil,
    from_address: nil,
    return_address: nil,
    buyer_address: nil,
    parcel: nil,
    rates: [],
    selected_rate: nil,
    is_return: false,
    tracking_code: nil,
    usps_zone: nil,
    status: "",
    refund_status: nil,
    batch_id: nil,
    batch_status: nil,
    batch_message: nil,
  ]

  @type t :: %__MODULE__{
    id: nil | String.t,
    mode: EasyPost.mode,
    created_at: DateTime.t,
    updated_at: DateTime.t,
    reference: nil | String.t,

    to_address: Address.t,
    from_address: Address.t,
    return_address: Address.t,
    buyer_address: Address.t,
    parcel: Parcel.t,
    # customs_info: CustomsInfo.t,
    # scan_form: nil | ScanForm.t,
    # forms: [Form.t],
    # insurance: nil | Insurance.t,
    rates: [Shipment.Rate.t],
    selected_rate: nil | Shipment.Rate.t,
    # postage_label: PostageLabel.t,
    # messages: [Message.t],
    # options: Options.t,
    is_return: boolean,
    tracking_code: nil | String.t,
    usps_zone: nil | String.t,
    status: String.t,
    # tracker: Tracker.t,
    # fees: [Fee.t],
    refund_status: nil | :submitted | :refunded | :rejected,
    batch_id: nil | String.t,
    batch_status: nil | String.t,
    batch_message: nil | String.t,
  }

  def create(params) do
    params = sanitize_params(params)
    @endpoint |> API.post(%{shipment: params}) |> API.format_response()
  end

  def retrieve_list(params) do
    @endpoint |> API.get([], params: params) |> API.format_response()
  end

  def retrieve(id) do
    "#{@endpoint}/#{id}" |> API.get() |> API.format_response()
  end

  defp sanitize_params(params) do
    Enum.reduce [:from_address, :to_address, :parcel], params, fn field, params ->
      Map.update!(params, field, fn
        id when is_binary(id) ->
          %{id: id}
        params ->
          if Map.has_key?(params, :id) do
            %{id: params.id}
          else
            params
          end
      end)
    end
  end
end
