defmodule EasyPost.Mixfile do
  use Mix.Project

  def project do
    [
      app: :easy_post,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "EasyPost",
      source_url: "https://github.com/system76/easy_post",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Build and runtime dependencies
      {:httpoison, "~> 0.13.0"},
      {:poison, "~> 3.0"},

      # Development and testing only dependencies
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
    ]
  end

  defp description do
    "An API client for EasyPost"
  end

  defp package do
    [
      name: "easy_post",
      maintainers: ["Ben Cates"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/system76/easy_post"},
    ]
  end
end
