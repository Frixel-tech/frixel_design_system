defmodule FrixelDesignSystem.CloudinaryApi do
  @moduledoc """
  Small wrapper around the Cloudinary API to list all image urls stored in cloud.

  ## Example

      iex> list_cloud_stored_images()
      {:ok, ["http://...", ...]}

      # in case of failed request
      iex> list_cloud_stored_images()
      {:error, reason}
  """
  require Logger

  @doc """
  A setup function to set Cloudinary params inside module state
  """
  @spec get_cloud_params() :: {String.t(), [{String.t(), String.t()}]}
  def get_cloud_params() do
    config = Application.get_env(:frixel_design_system, :cloudinary)
    base_url = "#{config[:api_base_url]}/#{config[:cloud_name]}/resources/image?max_results=100"

    request_headers = build_headers(config[:api_key], config[:api_secret])

    {base_url, request_headers}
  end

  @doc """
  Returns the list of all available images urls stored in our cloudinary cloud.

  ## Examples

      iex> list_cloud_stored_images(cloud_pid)
      {:ok, [
        "https://res.cloudinary.com/cloud_name/image/upload/v1747661611/eye-slash-solid_ancwvw.svg",
        "https://res.cloudinary.com/cloud_name/image/upload/v1747400879/LOGO_FRIXEL4_iavyp6.png",
        ...
      ]}

  """

  # On récupère la liste complète de toutes les images présentes sur notre CDN cloudinary.
  # Peut être pas optimale. À améliorer et récupérer les images par répertoire/sous répertoire (Mais la pagination sera toujours présente).
  @spec list_cloud_stored_images() ::
          {:ok, [String.t()]} | {:error, String.t()} | {:error, HTTPoison.Error.t()}
  def list_cloud_stored_images() do
    {base_url, request_headers} = get_cloud_params()
    Logger.info("GET request initiated for #{base_url}")

    HTTPoison.get(base_url, request_headers, [])
    |> handle_http_response()
  end

  @spec list_cloud_stored_images(String.t() | integer()) ::
          {:ok, [String.t()]} | {:error, String.t()} | {:error, HTTPoison.Error.t()}
  def list_cloud_stored_images(next_cursor) do
    {base_url, request_headers} = get_cloud_params()

    current_page_url = "#{base_url}&next_cursor=#{next_cursor}"

    Logger.info("GET request initiated for #{current_page_url}")

    HTTPoison.get(current_page_url, request_headers, [])
    |> handle_http_response()
  end

  # On construit les headers nécessaires pour la requêtte vers l'api de cloudinary.
  @spec build_headers(String.t(), String.t()) :: [{String.t(), String.t()}]
  defp build_headers(cloudinary_key, cloudinary_secret) do
    [
      {"Authorization", "Basic #{Base.encode64("#{cloudinary_key}:#{cloudinary_secret}")}"}
    ]
  end

  @spec handle_http_response({:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}) ::
          {:ok, [String.t()]} | {:error, String.t()} | {:error, HTTPoison.Error.t()}
  defp handle_http_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    body
    |> Jason.decode!()
    |> continues_fetching_or_returns()
  end

  defp handle_http_response({:ok, %HTTPoison.Response{status_code: code}}) do
    Logger.error(
      "[cloudinary.ex] - Error whith code #{code} when fetching cloudinary stored images"
    )

    {:error, "Cloudinary API returned status #{code}"}
  end

  defp handle_http_response({:error, reason}) do
    Logger.error(
      "[cloudinary.ex] - Error when fetching cloudinary stored images #{inspect(reason)}"
    )

    {:error, reason}
  end

  # On récupère les ressources des images et le curseur suivant, si ce dernier est nil
  # on relance l'Agent dans un reduce, sinon on retourne le résultat de la requête
  @spec continues_fetching_or_returns(%{
          optional(String.t()) => String.t() | integer(),
          resources: %{secure_url: String.t()}
        }) :: {:ok, [String.t()]} | {:error, String.t() | {:error, HTTPoison.Error.t()}}
  defp continues_fetching_or_returns(%{
         "next_cursor" => next_cursor,
         "resources" => ressources_fetched
       }) do
    # On construit une liste contenant les URL des ressources récupérées
    images_urls = Enum.map(ressources_fetched, & &1["secure_url"])

    # On n'est pas sur la dernière page, on continue le process de récupération des URL
    case list_cloud_stored_images(next_cursor) do
      {:ok, next_page_image_urls_list} ->
        new_image_urls_list =
          Enum.reduce(images_urls, next_page_image_urls_list, fn image, acc -> [image | acc] end)

        {:ok, new_image_urls_list}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp continues_fetching_or_returns(%{"resources" => ressources_fetched}) do
    # On construit une liste contenant les URL des ressources récupérées
    image_urls_list = Enum.map(ressources_fetched, & &1["secure_url"])

    # On est sur la dernière page, on retourne le résultat
    {:ok, image_urls_list}
  end
end
