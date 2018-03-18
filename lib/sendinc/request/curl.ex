defmodule Sendinc.Curl do
  @moduledoc """
  This module sends a Sendinc request through curl. Curl must be installed
  on the host machine.
  """

  alias Sendinc.Config, as: C

  def request(stringified_params) do
    params = ["-u", "#{C.email}:#{C.password}"] ++ stringified_params
    case System.cmd "curl", params do
      {output, 0} ->  IO.puts "#{output}"
      {err, code} -> {:error, code <> " --- \n " <> err}
    end
  end
end
