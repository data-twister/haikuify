defmodule Haikuify.Mixfile do
  use Mix.Project

  def project do
    [
      app: :haikuify,
      description:
        "Generate Heroku-like memorable random names to use in your apps or anywhere else.",
      version: "1.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        maintainers: ["Jason Clark"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/data-twister/haikuify"}
      ]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:earmark, "~> 1.4", only: :dev},
      {:ex_doc, "~> 0.25", only: :dev},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end
end

# rm -rf _build
# rm -rf deps

# mix deps.clean --all
# mix deps.get
