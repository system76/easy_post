defmodule EasyPost.API do
  use HTTPoison.Base

  import EasyPost.Helpers, only: [format_params: 1, hydrate_response: 1]

  require Logger

  @endpoint "https://api.easypost.com/v2/"

  def read(path, id) do
    get!("#{path}/#{id}") |> maybe_error |> hydrate_response
  end

  def create(path, params) do
    post!(path, format_params(params)) |> maybe_error |> hydrate_response
  end

  defp maybe_error(response) do
    case response do
      %{status_code: status_code, body: body} when status_code in 200..299 ->
        {:ok, body}

      %{status_code: status_code, body: body} when status_code in 400..499 ->
        {:error, body}

      _ ->
        {:error, "could not create address"} # FIXME: match error type and format
    end
  end

  defp process_url(url) do
    @endpoint <> url
  end

  defp process_request_headers(headers) do
    key = Application.get_env(:easy_post, :api_key)
    auth_string = Base.encode64("#{key}:")

    [{"Authorization", "Basic #{auth_string}"}] ++ headers
  end

  defp process_request_body(body) when is_binary(body), do: body
  defp process_request_body(params) when is_list(params) do
    Logger.debug("Request: " <> inspect(params))

    {:form, params}
  end

  defp process_response_body(body) do
    Logger.debug("Response: " <> body)

    Poison.decode! body
  end
end
