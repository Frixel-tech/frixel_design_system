defmodule FrixelDesignSystem.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # The default endpoint for testing
      @endpoint FrixelDesignSystem.Endpoint

      use FrixelDesignSystem, :verified_routes

      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import FrixelDesignSystem.ConnCase
    end
  end

  setup do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  @spec create_api_mock_server(any()) :: %{bypass: Bypass.t()}
  def create_api_mock_server(_) do
    bypass = Bypass.open()

    # Remplace temporairement l’URL de base Cloudinary
    Application.put_env(:frixel_design_system, :cloudinary,
      cloud_name: "test_cloud_name",
      api_key: "test_api_key",
      api_secret: "test_api_secret",
      api_base_url: "http://localhost:#{bypass.port}"
    )

    %{bypass: bypass}
  end
end
