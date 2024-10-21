defmodule TimeManager.TimeTracking.Application.ClockService do
  use TimeManager, :application_service

  alias TimeManager.TimeTracking.{
    ClockModel,
    Application.ClockRepository,
    Application.DateProvider
  }

  def clock_in_out(user_id) do
    last_clock = ClockRepository.get_last_by_id(user_id)

    case last_clock do
      nil ->
        insert_clock(user_id, "clock_in")

      last_clock ->
        case last_clock.status do
          :clock_in ->
            insert_clock(user_id, "clock_out")

          :clock_out ->
            insert_clock(user_id, "clock_in")
        end
    end
  end

  defp insert_clock(user_id, status) do
    %ClockModel{}
    |> ClockModel.changeset(%{status: status, user_id: user_id, time: DateProvider.now()})
    |> ClockRepository.insert()
  end

  def get_clocks() do
    ClockRepository.get_all()
  end

  def get_clocks_by_user(user_id) do
    ClockRepository.get_all_by_user(user_id)
  end

  def calculate_clock_stats(clocks) do
    total_time =
      clocks
      |> Enum.chunk_every(2)
      |> Enum.reduce(0, fn
        [%{status: :clock_in, time: start_time}, %{status: :clock_out, time: end_time}], acc ->
          acc + DateTime.diff(end_time, start_time, :hour)
        _, acc -> acc
      end)
    %{total_time: total_time}
  end

  def get_clocks_this_week(clocks) do
    # ClockRepository.get_all_by_user(user_id)
    now = DateProvider.now()
    beginning_of_week = Date.beginning_of_week(now)
    end_of_week = Date.end_of_week(now)

    filtered_clocks = clocks
    |> Enum.filter(fn clock ->
      Date.compare(clock.time, beginning_of_week) != :lt and Date.compare(clock.time, end_of_week) != :gt
    end)
    IO.inspect(filtered_clocks)
  end

end
