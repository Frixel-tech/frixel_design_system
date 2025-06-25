defmodule FrixelDesignSystem.CloudinaryApi do
  @moduledoc """
  Small wrapper around the Cloudinary API to keep connection paramters inside state end to list all image urls stored in cloud.

  ## Example

      iex> {:ok, cloud_pid} = set_cloud_connection(cloudinary_base_url, cloud_name, cloudinary_key, cloudinary_secret)
      iex> list_cloud_stored_images(cloud_pid)
      {:ok, ["http://...", ...]}

      # in case of failed request
      iex> list_cloud_stored_images(cloud_pid)
      {:error, reason}
  """
  use Agent

  require Logger

  @typedoc "A standard pid as returned by the module Agent.start_link/1"
  @type cloud_pid() :: atom() | pid() | {atom(), any()} | {:via, atom(), any()}

  @doc """
  A setup function to set Cloudinary params inside module state
  """
  @spec set_cloud_connection(String.t(), String.t(), String.t(), String.t()) ::
          {:error, any()} | {:ok, pid()}
  def set_cloud_connection(
        cloudinary_base_url,
        cloud_name,
        cloudinary_key,
        cloudinary_secret
      ) do
    base_url = "#{cloudinary_base_url}/#{cloud_name}/resources/image?max_results=100"

    request_headers = build_headers(cloudinary_key, cloudinary_secret)

    Agent.start_link(fn ->
      %{
        base_url: base_url,
        request_headers: request_headers
      }
    end)
  end

  @doc """
  Returns the list of all available images urls stored in our cloudinary cloud.

  ## Examples

      iex> list_cloud_stored_images(cloud_pid)
      {:ok, [
        "https://res.cloudinary.com/dekpcimmm/image/upload/v1747661611/eye-slash-solid_ancwvw.svg",
        "https://res.cloudinary.com/dekpcimmm/image/upload/v1747400879/LOGO_FRIXEL4_iavyp6.png",
        ...
      ]}

  """

  # On récupère la liste complète de toutes les images présentes sur notre CDN cloudinary.
  # Peut être pas optimale. À améliorer et récupérer les images par répertoire/sous répertoire (Mais la pagination sera toujours présente).
  @spec list_cloud_stored_images(cloud_pid()) :: {:ok, [String.t()]} | {:error, any()}
  def list_cloud_stored_images(cloud_pid) do
    Agent.get(cloud_pid, fn connection ->
      connection |> IO.inspect(label: "Connectoion state")
      HTTPoison.get(connection.base_url, connection.request_headers, [])
    end)
    |> handle_http_response(cloud_pid)
  end

  @spec list_cloud_stored_images(cloud_pid(), String.t() | integer()) ::
          {:ok, [String.t()]} | {:error, any()}
  def list_cloud_stored_images(cloud_pid, next_cursor) do
    Agent.get(cloud_pid, fn connection ->
      current_page_url = "#{connection.base_url}&next_cursor=#{next_cursor}"

      HTTPoison.get(current_page_url, connection.request_headers, [])
    end)
    |> handle_http_response(cloud_pid)
  end

  # On construit les headers nécessaires pour la requêtte vers l'api de cloudinary.
  @spec build_headers(String.t(), String.t()) :: [{String.t(), String.t()}]
  defp build_headers(cloudinary_key, cloudinary_secret) do
    [
      {"Authorization", "Basic #{Base.encode64("#{cloudinary_key}:#{cloudinary_secret}")}"}
    ]
  end

  @spec handle_http_response(
          {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()},
          cloud_pid()
        ) ::
          {:ok, [String.t()]} | {:error, String.t()} | {:error, HTTPoison.Error.t()}
  defp handle_http_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}, cloud_pid) do
    body
    |> Jason.decode!()
    |> continues_fetching_or_returns(cloud_pid)
  end

  defp handle_http_response({:ok, %HTTPoison.Response{status_code: code}}, _cloud_pid) do
    Logger.error(
      "[cloudinary.ex] - Error whith code #{code} when fetching cloudinary stored images"
    )

    {:error, "Cloudinary API returned status #{code}"}
  end

  defp handle_http_response({:error, reason}, _cloud_pid) do
    Logger.error(
      "[cloudinary.ex] - Error when fetching cloudinary stored images #{inspect(reason)}"
    )

    {:error, reason}
  end

  # On récupère les ressources des images et le curseur suivant, si ce dernier est nil
  # on relance l'Agent dans un reduce, sinon on retourne le résultat de la requête
  @spec continues_fetching_or_returns(
          %{
            next_cursor: nil | String.t() | integer(),
            resources: %{secure_url: String.t()}
          },
          cloud_pid()
        ) :: {:ok, [String.t()]} | {:error, String.t() | {:error, HTTPoison.Error.t()}}
  defp continues_fetching_or_returns(
         %{"next_cursor" => nil, "resources" => ressources_fetched},
         _cloud_pid
       ) do
    # On construit une liste contenant les URL des ressources récupérées
    image_urls_list = Enum.map(ressources_fetched, & &1["secure_url"])

    # On est sur la dernière page, on retourne le résultat
    {:ok, image_urls_list}
  end

  defp continues_fetching_or_returns(
         %{
           "next_cursor" => next_cursor,
           "resources" => ressources_fetched
         },
         cloud_pid
       ) do
    # On construit une liste contenant les URL des ressources récupérées
    images_urls = Enum.map(ressources_fetched, & &1["secure_url"])

    # On n'est pas sur la dernière page, on continue le process de récupération des URL
    case list_cloud_stored_images(cloud_pid, next_cursor) do
      {:ok, next_page_image_urls_list} ->
        new_image_urls_list =
          Enum.reduce(images_urls, next_page_image_urls_list, fn image, acc -> [image | acc] end)

        {:ok, new_image_urls_list}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
