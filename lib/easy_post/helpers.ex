defmodule EasyPost.Helpers do

  def format_params(params_map) do
    Enum.flat_map(params_map, fn {key, item} ->
      do_format_params("#{key}", item)
    end)
  end

  defp do_format_params(prefix, item_map) when is_map(item_map) do
    Enum.flat_map(item_map, fn {key, item} ->
      do_format_params("#{prefix}[#{key}]", item)
    end)
  end
  defp do_format_params(prefix, item_list) when is_list(item_list) do
    Enum.flat_map(item_list, fn item ->
      do_format_params("#{prefix}[]", item)
    end)
  end
  defp do_format_params(prefix, item) do
    [{prefix, item}]
  end

  def hydrate_response({:error, reason}), do: {:error, reason}
  def hydrate_response({:ok, raw_response}) do
    resource_module = module_for(raw_response["object"])

    resource_data =
      raw_response
      |> deep_atomize_keys
      |> mode_field(:mode)
      |> date_field(:created_at)
      |> date_field(:updated_at)

    resource = struct(resource_module, resource_data)

    {:ok, resource}
  end

  defp module_for("Address"), do: EasyPost.Address
  defp module_for("Parcel"), do: EasyPost.Parcel
  defp module_for("Shipment"), do: EasyPost.Shipment

  def mode_field(resource, key),
    do: Map.update!(resource, key, &String.to_existing_atom/1)

  def date_field(resource, key) do
    Map.update!(resource, key, fn val ->
      case DateTime.from_iso8601(val) do
        {:ok, date_time, _} -> date_time
        {:error, _} -> nil
      end
    end)
  end

  defp deep_atomize_keys(obj) when is_map(obj) do
    obj
    |> Enum.map(fn {k, v} -> {String.to_atom(k), deep_atomize_keys(v)} end)
    |> Enum.into(%{})
  end
  defp deep_atomize_keys(obj) when is_list(obj) do
    Enum.map(obj, &deep_atomize_keys/1)
  end
  defp deep_atomize_keys(obj) do
    obj
  end
end
