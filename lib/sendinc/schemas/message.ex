defmodule Sendinc.Message do
  @moduledoc """
  This module handles metadata related to messages associated with
  Send Inc.

  For more information, check out
  [this](http://docs.sendinc.com/docs/rest-api#attachments) url

  ## Usage
  """

  use Sendinc.Schema

  sendinc_schema do
    field :email, :string
    embeds_many :recipients, :string
    embeds_many :recipients_cc, :string
    embeds_many :recipients_bcc, :string
    field :copy_me, :boolean
    field :notify, :boolean
    field :expire_when_read, :boolean
    field :subject, :string
    field :message, :string
    embeds_many :attachments, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :recipients, :recipients_cc, :recipients_bcc,
                     :copy_me, :notify, :expire_when_read, :subject, :message,
                     :attachments])
    |> validate_format(:email, ~r/@/)
    |> validate_required([:email, :recipients, :subject, :message])
  end
end
