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
    embeds_many :recipients, Sendinc.Message.Email
    embeds_many :recipients_cc, Sendinc.Message.Email
    embeds_many :recipients_bcc, Sendinc.Message.Email
    field :copy_me, :boolean
    field :notify, :boolean
    field :expire_when_read, :boolean
    field :subject, :string
    field :message, :string
    embeds_many :attachments, Sendinc.Message.Attachment
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :copy_me, :notify, :expire_when_read, :subject,
                     :message])
    |> cast_embed(:recipients)
    |> cast_embed(:recipients_cc)
    |> cast_embed(:recipients_bcc)
    |> cast_embed(:attachments)
    |> validate_format(:email, ~r/@/)
    |> validate_required([:email, :recipients, :subject, :message])
  end
end

defmodule Sendinc.Message.Email do
  @moduledoc false
  use Sendinc.Schema

  sendinc_schema do
    field :email, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
  end
end

defmodule Sendinc.Message.Attachment do
  @moduledoc false
  use Sendinc.Schema

  sendinc_schema do
    field :path, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:path])
    |> validate_required([:path])
  end
end
