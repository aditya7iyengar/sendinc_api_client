defmodule Sendinc.MessageTranslator do
  @moduledoc """
  This module translates a struct to a url with params to make request to
  """


  def translate(%{errors: errors}, _) when errors != [] do
    raise "Error in changeset!"
  end

  def translate(struct, :create) do
    base(:create) ++ fields(struct) ++ ["https://rest.sendinc.com/message.json"]
  end

  defp base(:create), do:  ["-XPOST"]
  defp base(:get), do:  []

  defp fields(struct) do
    struct.changes
    |> Map.keys()
    |> Enum.reduce([], fn(field, acc) ->
      acc ++ ["-F", "#{to_string(field)}=#{translate_field(struct, field)}"]
    end)
  end

  defp translate_field(struct, many)
  when many in [:recipients, :recipients_cc, :recipients_bcc] do
    struct.changes
    |> Map.get(many)
    |> Enum.map(&Map.get(&1.changes, :email))
    |> Enum.join(",")
  end
  defp translate_field(struct, :attachments) do
    struct.changes
    |> Map.get(:attachments)
    |> Enum.map(&Map.get(&1.changes, :path))
    |> Enum.join(",")
  end
  defp translate_field(struct, field), do: Map.get(struct.changes, field)
end
