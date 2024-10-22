defmodule TimeManager.TimeTracking.Infrastructure.ClockPresenter do
  @self __MODULE__
  use TimeManagerWeb, :view

  alias TimeManager.TimeTracking.ClockModel

  def present_clock(%{clock: %ClockModel{} = clock}) do
    %{
      id: clock.id,
      status: clock.status,
      user_id: clock.user_id,
      time: clock.time
    }
  end

  def present_clocks(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: present_clock(%{clock: clock}))}
  end

  def present_stats(%{stats: stats}) do
    %{
      last_stats_week: stats[:last_stats_week][:total_time],
      percentage: stats[:percentage],
      this_week_stats: stats[:this_week_stats][:total_time]
    }
  end

  def render_result(conn, result, status \\ :ok)

  def render_result(conn, result, status) when is_list(result) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_clocks, clocks: result)
  end

  def render_result(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_clock, clock: result)
  end

  def render_stats(conn, result, status \\ :ok) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_stats, stats: result)
  end

  def render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
