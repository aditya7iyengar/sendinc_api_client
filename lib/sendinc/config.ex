defmodule Sendinc.Config do
  @moduledoc """
  An interface to fetch configurations for SendInc API Client
  """

  def email() do
    config(:email, System.get_env("SENDINC_EMAIL"))
  end

  def password() do
    config(:password, System.get_env("SENDINC_PASSWORD"))
  end

  def timeout() do
    config(:timeout, 8000)
  end

  def requester() do
    config(:requester, Sendinc.Curl)
  end

  def config(key, default \\ nil) do
    :sendinc_api_client
    |> Application.get_env(:configure, [])
    |> Keyword.get(key, default)
  end
end
