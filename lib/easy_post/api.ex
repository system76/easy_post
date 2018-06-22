defmodule EasyPost.API do
  use HTTPoison.Base

  import EasyPost.Helpers, only: [format_params: 1, hydrate_response: 1]

  require Logger

  @endpoint "https://api.easypost.com/v2/"

  def format_response(response) do
    response |> maybe_error() |> hydrate_response()
  end

  defp maybe_error({:error, reason}), do: {:error, reason}
  defp maybe_error({:ok, response}) do
    case response do
      %{status_code: status_code, body: body} when status_code in 200..299 ->
        {:ok, body}

      %{status_code: status_code, body: body} when status_code in 400..499 ->
        {:error, %EasyPost.Error{
          code: get_in(body, ["error", "code"]),
          message: get_in(body, ["error", "message"]),
          errors: Enum.map(get_in(body, ["error", "errors"]), fn field_error ->
            %{
              field: field_error["field"],
              message: field_error["message"],
            }
          end)
        }}

      _ ->
        {:error, %HTTPoison.Error{reason: "could not parse response"}}
    end
  end

  defp process_url(url), do: @endpoint <> url

  defp process_request_headers(headers) do
    key = Application.get_env(:easy_post, :api_key)
    auth_string = Base.encode64("#{key}:")

    [{"Authorization", "Basic #{auth_string}"}] ++ headers
  end

  defp process_request_body(body) when is_binary(body),
    do: body
  defp process_request_body(params) when is_map(params),
    do: process_request_body(format_params(params))
  defp process_request_body(params) when is_list(params) do
    Logger.debug("Request: " <> inspect(params))

    {:form, params}
  end

  defp process_response_body(body) do
    Logger.debug("Response: " <> body)

    Poison.decode! body
  end
end
