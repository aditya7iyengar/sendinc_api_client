defmodule Sendinc.Schema do
  @moduledoc """
  This module defines behaviour a schema must implement to work with
  this package.
  """

  @doc """
  This macro creates a SendInc accessible API Schema abstraction
  """
  defmacro sendinc_schema(do: fields) do
    quote do
      @primary_key false
      embedded_schema(do: unquote(fields))
    end
  end

  @doc """
  This macro allows us to bring in Schema functionality to a module's
  lexical context.
  """
  defmacro __using__(opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      import unquote(__MODULE__)

      def changeset(struct, params) do
        raise "Undefined changeset/2 for #{__MODULE__}"
      end

      defoverridable [changeset: 2]
    end
  end
end
