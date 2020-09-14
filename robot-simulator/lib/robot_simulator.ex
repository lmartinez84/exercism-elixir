defmodule RobotSimulator do
  defguard has_valid_direction(direction) when direction in [:north, :east, :south, :west]

  defguard has_valid_position(position)
           when is_tuple(position) and tuple_size(position) == 2 and is_integer(elem(position, 0)) and
                  is_integer(elem(position, 1))

  defguard is_pointing_north(direction) when direction == :north
  defguard is_pointing_south(direction) when direction == :south
  defguard is_pointing_west(direction) when direction == :west
  defguard is_pointing_east(direction) when direction == :east

  defguard is_valid_instruction(instruction) when instruction in [?L, ?R, ?A]

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
    instructions
    |> String.to_charlist()
    |> Enum.reduce(robot, fn inst, actual -> run(actual, inst) end)
  end

  def run(robot = %{direction: dir}, ?L) when is_pointing_north(dir),
    do: %{robot | direction: :west}

  def run(robot = %{direction: dir}, ?L) when is_pointing_south(dir),
    do: %{robot | direction: :east}

  def run(robot = %{direction: dir}, ?L) when is_pointing_west(dir),
    do: %{robot | direction: :south}

  def run(robot = %{direction: dir}, ?L) when is_pointing_east(dir),
    do: %{robot | direction: :north}

  def run(robot = %{direction: dir}, ?R) when is_pointing_north(dir),
    do: %{robot | direction: :east}

  def run(robot = %{direction: dir}, ?R) when is_pointing_south(dir),
    do: %{robot | direction: :west}

  def run(robot = %{direction: dir}, ?R) when is_pointing_west(dir),
    do: %{robot | direction: :north}

  def run(robot = %{direction: dir}, ?R) when is_pointing_east(dir),
    do: %{robot | direction: :south}

  def run(robot = %{direction: dir, position: {x, y}}, ?A) when is_pointing_north(dir),
    do: %{robot | position: {x, y + 1}}

  def run(robot = %{direction: dir, position: {x, y}}, ?A) when is_pointing_south(dir),
    do: %{robot | position: {x, y - 1}}

  def run(robot = %{direction: dir, position: {x, y}}, ?A) when is_pointing_west(dir),
    do: %{robot | position: {x - 1, y}}

  def run(robot = %{direction: dir, position: {x, y}}, ?A) when is_pointing_east(dir),
    do: %{robot | position: {x + 1, y}}

  def run(_robot, _instruction), do: {:error, "invalid instruction"}

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
