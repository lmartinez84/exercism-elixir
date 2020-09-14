defmodule RobotSimulator do
  defguard has_valid_direction(direction) when direction in [:north, :east, :south, :west]

  defguard has_valid_position(position)
           when is_tuple(position) and tuple_size(position) == 2 and is_integer(elem(position, 0)) and
                  is_integer(elem(position, 1))

  defmodule Robot do
    @enforce_keys [:position, :direction]
    defstruct [:position, :direction]
  end

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction, position)
      when has_valid_direction(direction) and has_valid_position(position) do
    %Robot{position: position, direction: direction}
  end

  def create(direction, _position) when not has_valid_direction(direction) do
    {:error, "invalid direction"}
  end

  def create(_direction, position) when not has_valid_position(position) do
    {:error, "invalid position"}
  end

  def create() do
    %Robot{position: {0, 0}, direction: :north}
  end

  @doc """
  Simulate the robot's executement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    run(robot, String.to_charlist(instructions))
  end

  defp run(robot = %{direction: :north}, [?L | instructions]),
    do: %{robot | direction: :west} |> run(instructions)

  defp run(robot = %{direction: :south}, [?L | instructions]),
    do: %{robot | direction: :east} |> run(instructions)

  defp run(robot = %{direction: :west}, [?L | instructions]),
    do: %{robot | direction: :south} |> run(instructions)

  defp run(robot = %{direction: :east}, [?L | instructions]),
    do: %{robot | direction: :north} |> run(instructions)

  defp run(robot = %{direction: :north}, [?R | instructions]),
    do: %{robot | direction: :east} |> run(instructions)

  defp run(robot = %{direction: :south}, [?R | instructions]),
    do: %{robot | direction: :west} |> run(instructions)

  defp run(robot = %{direction: :west}, [?R | instructions]),
    do: %{robot | direction: :north} |> run(instructions)

  defp run(robot = %{direction: :east}, [?R | instructions]),
    do: %{robot | direction: :south} |> run(instructions)

  defp run(robot = %{direction: :north, position: {x, y}}, [?A | instructions]),
    do: %{robot | position: {x, y + 1}} |> run(instructions)

  defp run(robot = %{direction: :south, position: {x, y}}, [?A | instructions]),
    do: %{robot | position: {x, y - 1}} |> run(instructions)

  defp run(robot = %{direction: :west, position: {x, y}}, [?A | instructions]),
    do: %{robot | position: {x - 1, y}} |> run(instructions)

  defp run(robot = %{direction: :east, position: {x, y}}, [?A | instructions]),
    do: %{robot | position: {x + 1, y}} |> run(instructions)

  defp run(_robot, [_invalid_instruction | _]), do: {:error, "invalid instruction"}

  defp run(robot, []), do: robot

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
