defmodule LychrelNumbers.Application do
  use Application

  def start(_type, _args) do
    LychrelNumbers.Supervisor.start_link
  end
end
