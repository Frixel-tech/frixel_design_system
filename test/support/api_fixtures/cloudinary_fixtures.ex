defmodule FrixelDesignSystem.ApiFixtures.CloudinaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities for cloudinary API use cases.
  """

  def mock_cloudinary_fetched_images_with_pagination(conn, query) do
    case query["next_cursor"] do
      nil ->
        Plug.Conn.resp(
          conn,
          200,
          Jason.encode!(%{
            "resources" => [
              %{"secure_url" => "https://cdn.test/image1.jpg"},
              %{"secure_url" => "https://cdn.test/image2.jpg"},
              %{"secure_url" => "https://cdn.test/image3.jpg"},
              %{"secure_url" => "https://cdn.test/image4.jpg"},
              %{"secure_url" => "https://cdn.test/image5.jpg"}
            ],
            "next_cursor" => "secondPage"
          })
        )

      "secondPage" ->
        Plug.Conn.resp(
          conn,
          200,
          Jason.encode!(%{
            "resources" => [
              %{"secure_url" => "https://cdn.test/image6.jpg"},
              %{"secure_url" => "https://cdn.test/image7.jpg"},
              %{"secure_url" => "https://cdn.test/image8.jpg"},
              %{"secure_url" => "https://cdn.test/image9.jpg"},
              %{"secure_url" => "https://cdn.test/image10.jpg"}
            ]
          })
        )

      _ ->
        Plug.Conn.resp(conn, 400, Jason.encode!(%{error: "unexpected cursor"}))
    end
  end

  def mock_broken_cursor_cloudinary_request(conn, query) do
    case query["next_cursor"] do
      nil ->
        Plug.Conn.resp(
          conn,
          200,
          Jason.encode!(%{
            "resources" => [
              %{"secure_url" => "https://cdn.test/image1.jpg"},
              %{"secure_url" => "https://cdn.test/image2.jpg"},
              %{"secure_url" => "https://cdn.test/image3.jpg"},
              %{"secure_url" => "https://cdn.test/image4.jpg"},
              %{"secure_url" => "https://cdn.test/image5.jpg"}
            ],
            "next_cursor" => "broken_cursor"
          })
        )

      "broken_cursor" ->
        Plug.Conn.resp(conn, 400, Jason.encode!(%{error: "unexpected cursor"}))
    end
  end
end
