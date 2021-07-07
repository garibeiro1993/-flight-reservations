defmodule Flightex.Users.User do
  @mandatory_keys [:name, :email, :cpf]
  @non_mandatory_keys [:id]
  @enforce_keys @mandatory_keys

  defstruct @mandatory_keys ++ @non_mandatory_keys

  def build(name, email, cpf) when is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       name: name,
       email: email,
       cpf: cpf
     }}
  end

  def build(_name, _email, _cpf), do: {:error, "Cpf must be a String"}
end
