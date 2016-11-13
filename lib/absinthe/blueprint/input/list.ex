defmodule Absinthe.Blueprint.Input.List do

  @moduledoc false

  alias Absinthe.{Blueprint, Phase}

  @enforce_keys [:items]
  defstruct [
    :items,
    :source_location,
    # Added by phases
    flags: %{},
    schema_node: nil,
    errors: [],
  ]

  @type t :: %__MODULE__{
    items: [Blueprint.Input.Value.t],
    flags: Blueprint.flags_t,
    schema_node: nil | Absinthe.Type.t,
    source_location: Blueprint.Document.SourceLocation.t,
    errors: [Phase.Error.t],
  }

  @doc """
  Wrap another input node in a list.
  """
  @spec wrap(Blueprint.Input.t, Absinthe.Type.List.t) :: t
  def wrap(%__MODULE__{} = list, _), do: list
  def wrap(node, list_schema_node) do
    %__MODULE__{
      items: [
        %Blueprint.Input.Value{
          literal: node,
          normalized: node,
          schema_node: node.schema_node.of_type
        }
      ],
      source_location: node.source_location,
      schema_node: list_schema_node
    }
  end
end