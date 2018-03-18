defmodule SendincApiClientTest do
  use ExUnit.Case
  doctest SendincApiClient

  test "greets the world" do
    assert SendincApiClient.hello() == :world
  end
end
