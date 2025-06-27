defmodule FrixelDesignSystem.CloudinaryApiTest do
  use FrixelDesignSystem.ConnCase
  import FrixelDesignSystem.ApiFixtures.CloudinaryFixtures
  alias FrixelDesignSystem.CloudinaryApi

  setup [:create_api_mock_server]

  test "list_cloud_stored_images/0 should return {:ok, list_of_imag_urls}", %{
    bypass: bypass
  } do
    Bypass.expect(bypass, fn conn ->
      path = conn.request_path
      query = URI.decode_query(conn.query_string)
      assert path == "/test_cloud_name/resources/image"

      # On mock la réponse attendue (venant de l'API cloudinary)
      mock_cloudinary_fetched_images_with_pagination(conn, query)
    end)

    {:ok, img_urls_list} = CloudinaryApi.list_cloud_stored_images()

    assert is_list(img_urls_list)

    assert "https://cdn.test/image1.jpg" in img_urls_list
    assert "https://cdn.test/image10.jpg" in img_urls_list
  end

  test "list_cloud_stored_images/0 with a returned bad cursor name should returns {:error, \"Cloudinary API returned status 400\"}",
       %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      path = conn.request_path
      query = URI.decode_query(conn.query_string)
      assert path == "/test_cloud_name/resources/image"

      # On mock la réponse attendue (venant de l'API cloudinary)
      mock_broken_cursor_cloudinary_request(conn, query)
    end)

    assert CloudinaryApi.list_cloud_stored_images() ==
             {:error, "Cloudinary API returned status 400"}
  end

  test "list_cloud_stored_images/0 with a broken connection should return {:error, reason}", %{
    bypass: bypass
  } do
    Bypass.down(bypass)

    assert CloudinaryApi.list_cloud_stored_images() ==
             {:error, %HTTPoison.Error{reason: :econnrefused}}
  end

  test "list_cloud_stored_images/1 with bad cursor should return {:error, \"Cloudinary API returned status 400\"",
       %{
         bypass: bypass
       } do
    Bypass.expect(bypass, fn conn ->
      path = conn.request_path
      query = URI.decode_query(conn.query_string)
      assert path == "/test_cloud_name/resources/image"
      assert conn.params["next_cursor"] == "bad_cursor"

      # On mock la réponse attendue (venant de l'API cloudinary)
      mock_cloudinary_fetched_images_with_pagination(conn, query)
    end)

    assert CloudinaryApi.list_cloud_stored_images("bad_cursor") ==
             {:error, "Cloudinary API returned status 400"}
  end

  test "get_cloud_params/0 should return the Application env var", %{bypass: bypass} do
    base_64_encoded_key_and_secret = Base.encode64("test_api_key:test_api_secret")

    assert CloudinaryApi.get_cloud_params() ==
             {"http://localhost:#{bypass.port}/test_cloud_name/resources/image?max_results=100",
              [
                {"Authorization", "Basic #{base_64_encoded_key_and_secret}"}
              ]}
  end
end
