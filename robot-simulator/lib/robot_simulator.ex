defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defmodule Robot do
    @enforce_keys [:position, :direction]
    defstruct [:position, :direction]
  end

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    with {:ok, dir} <- get_direction(direction),
         {:ok, pos} <- get_position(position) do
      %Robot{position: pos, direction: dir}
    end
  end

  defp get_position({x, y}) when is_integer(x) and is_integer(y), do: {:ok, {x, y}}
  defp get_position(_), do: {:error, "invalid position"}

  defp get_direction(direction) when direction in @directions, do: {:ok, direction}
  defp get_direction(_), do: {:error, "invalid direction"}

  @doc """
  Simulate the robot's executement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    with {:ok, instructions} <- get_instructions(instructions) do
      instructions
      |> Enum.reduce(
        robot,
        fn instruction, actual_robot -> execute(actual_robot, instruction) end
        )
    end
  end

  def get_instructions(instructions) do
    number_of_instructions = String.length(instructions)
    {valid_instructions, count} = get_valid_instructions(instructions)

    if number_of_instructions == count do
      {:ok, valid_instructions}
    else
      {:error, "invalid instruction"}
    end
  end

  defp get_valid_instructions(instructions) do
    String.to_charlist(instructions)
    |> Enum.filter(fn instruction -> instruction in [?L, ?R, ?A] end)
    |> Enum.map_reduce(0, fn instruction, count -> { instruction,  count + 1 } end)
  end

  def execute(robot, ?L) do
    direction = direction(robot)

    case direction do
      :north -> %{robot | direction: :west}
      :west -> %{robot | direction: :south}
      :east -> %{robot | direction: :north}
      :south -> %{robot | direction: :east}
    end
  end

  def execute(robot, ?R) do
    direction = direction(robot)

    case direction do
      :north -> %{robot | direction: :east}
      :west -> %{robot | direction: :north}
      :east -> %{robot | direction: :south}
      :south -> %{robot | direction: :west}
    end
  end

  def execute(robot, ?A) do
    direction = direction(robot)
    {x, y} = position(robot)

    case direction do
      :north -> %{robot | position: {x, y + 1}}
      :west -> %{robot | position: {x - 1, y}}
      :east -> %{robot | position: {x + 1, y}}
      :south -> %{robot | position: {x, y - 1}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
