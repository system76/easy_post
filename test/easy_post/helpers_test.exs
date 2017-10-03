defmodule EasyPost.HelpersTest do
  use ExUnit.Case, async: false

  alias EasyPost.Helpers

  @accepted_params %{
    address: %{
      name: "Carl Richell",
      company: "System76",
      street1: "1600 Champa",
      street2: "Suite 360",
      city: "Denver",
      state: "CO",
      zip: "80202",
      country: "US",
    },
    verify: ["zip4", "delivery"],
  }

  @actual_params [
    {"address[city]", "Denver"},
    {"address[company]", "System76"},
    {"address[country]", "US"},
    {"address[name]", "Carl Richell"},
    {"address[state]", "CO"},
    {"address[street1]", "1600 Champa"},
    {"address[street2]", "Suite 360"},
    {"address[zip]", "80202"},
    {"verify[]", "zip4"},
    {"verify[]", "delivery"},
  ]

  test "formatting parameters" do
    assert Helpers.format_params(@accepted_params) == @actual_params
  end
end
