defmodule FrixelDesignSystem do
  @moduledoc """
  FrixelDesignSystem keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defmacro __using__(_) do
    quote do
      alias FrixelDesignSystem.Components.{
        Button,
        Company,
        Form,
        Header,
        Menu,
        Product,
        Project
      }

      alias FrixelDesignSystem.{CloudinaryApi, Helper, Section}
    end
  end
end
