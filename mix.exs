defmodule ElixirTraining.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_training,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "HelloWorld",
      source_url: "https://github.com/grosendo2006/elixir_training",
      docs: [
        main: "HelloWorld",
        extras: ["README.md"]
      ]
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
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
