defmodule TimeManager.TimeTracking.Infrastructure.ClockPresenter do
  alias TimeManager.TimeTracking.Clock

  def present_clock(%{clock: %Clock{} = clock}) do
    %{
      id: clock.id,
      time: clock.time,
      status: clock.status,
      user_id: clock.user_id
    }
  end

  def present_clocks(%{clocks: clocks}) do
    %{
      data:
        for(
          clock <- clocks,
          do: present_clock(%{clock: clock})
        )
    }
  end
end
