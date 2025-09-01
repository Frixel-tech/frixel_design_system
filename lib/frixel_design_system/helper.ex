defmodule FrixelDesignSystem.Helper do
  @moduledoc """
  This module holds different helper functions used by your application.
  """

  @typedoc """
  An application environment state defined by an atom such as `:dev`, `:test` or `:prod`
  """
  @type app_env() :: :dev | :test | :prod

  @doc """
  Gets the environnement built

  ## Examples

      iex> get_config_env(:my_app)
      :dev

      iex> get_config_env(:my_app)
      :test

      iex> get_config_env(:my_app)
      :prod
  """
  @spec get_config_env(atom()) :: app_env()
  def get_config_env(app_name) do
    Application.get_env(app_name, :env)
  end

  @doc """
    Takes a string and replace some value by HTML balises , then prints the HTML value by using the function row()

      ## Examples

      iex> format_texte("Tata va se rendre chez Titi.\nElle le fera demain soir.")
      Tata va se rendre chez Titi.<br /> Elle le fera demain soir.

  """
  def format_text(nil), do: Phoenix.HTML.raw("")

  def format_text(description) do
    description
    |> String.replace("\n", "<br />")
    |> String.replace("[bold", "<span class=\"font-bold font-common\">")
    |> String.replace("bold]", "</span>")
    |> String.replace("[list", "<ul class=\"list-disc\">")
    |> String.replace("list]", "</ul>")
    |> String.replace("[elem", "<li class=\"font-common\">")
    |> String.replace("elem]", "</li>")
    |> String.replace("[text", "<p class=\"font-common\">")
    |> String.replace("text]", "</p>")
    |> Phoenix.HTML.raw()
  end
end
