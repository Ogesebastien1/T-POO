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
end
