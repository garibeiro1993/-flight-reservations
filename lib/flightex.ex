defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate

  def start_agents do
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update(params), to: CreateOrUpdate, as: :call
end
