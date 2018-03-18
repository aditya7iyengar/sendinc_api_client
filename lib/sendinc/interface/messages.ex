defmodule Sendinc.Messages do
  @moduledoc """
  This module is an interface to interact with Sendinc.Message schema
  """

  use Sendinc.Interface

  @schema Sendinc.Message
  @translator Sendinc.MessageTranslator
  @struct %Sendinc.Message{}
end
