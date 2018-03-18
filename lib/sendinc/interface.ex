defmodule Sendinc.Interface do
  @moduledoc """
  This module defines behaviour an interface must implement to work with
  this package.
  """

  @callback create(map, atom) :: {:ok, term} | {:error, term}
  @callback get(map, atom) :: {:ok, term} | {:error, term}

  defmacro __using__(opts) do
    quote do
      @behaviour unquote(__MODULE__)

      def create(params, requester \\ :default) do
        struct()
        |> schema.changeset(params)
        |> translator().translate(:create)
        |> get_requester(requester).request()
      end

      def get(params, requester \\ :default) do
        struct()
        |> schema.changeset(params)
        |> translator().translate(:get)
        |> get_requester(requester).request()
      end

      defp schema() do
        case Module.get_attribute(__MODULE__, :schema) do
          nil -> raise "@schema undefined for #{__MODULE__}"
          schema -> schema
        end
      end

      defp translator() do
        case Module.get_attribute(__MODULE__, :translator) do
          nil -> raise "@translator undefined for #{__MODULE__}"
          translator -> translator
        end
      end

      defp struct() do
        case Module.get_attribute(__MODULE__, :struct) do
          nil -> raise "@struct undefined for #{__MODULE__}"
          struct -> struct
        end
      end

      defp get_requester(:default), do: Sendinc.Config.requester()
      defp get_requester(requester), do: requester

      defoverridable [create: 2, get: 2]
    end
  end
end
