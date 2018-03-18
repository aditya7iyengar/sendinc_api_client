defmodule SendincApiClient.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/aditya7iyengar/sendinc_api_client"

  def project do
    [
      app: :sendinc_api_client,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env == :prod,
      deps: deps(),

      # Hex
      description: description(),
      package: package(),

      # Docs
      name: "SendInc API Client",
      docs: docs(),
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Adi Iyengar"],
      licenses: ["MIT"],
      links: %{"Github" => @url},
    ]
  end

  defp deps do
    [
      {:ecto, "~> 2.2"},
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
    ]
  end

  defp description do
    """
    An elixir wrapper around SendInc API Client
    """
  end

  def docs do
    [
      main: "Sendinc.Curl",
      source_url: @url,
      source_ref: "v#{@version}"
    ]
  end
end
