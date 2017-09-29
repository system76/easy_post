defmodule EasyPost.Shipment do
  import EasyPost.Helpers
  alias EasyPost.{API, Address, Parcel}

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
    # rates: Rate.t,
    # selected_rate: Rate.t,
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
end
