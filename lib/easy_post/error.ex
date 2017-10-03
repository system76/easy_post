defmodule EasyPost.Error do
  defexception [:code, :message, :errors]

  @type t :: %__MODULE__{
    code: String.t,
    message: String.t,
    errors: [field_error],
  }

  @type field_error :: %{
    field: String.t,
    message: String.t,
  }
end
