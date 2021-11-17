defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level === 0 and !legacy? -> :trace
      level === 1 -> :debug
      level === 2 -> :info
      level === 3 -> :warning
      level === 4 -> :error
      level === 5 and !legacy? -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    error_type = to_label(level, legacy?)

    cond do
      error_type == :error or error_type == :fatal -> :ops
      error_type == :unknown and legacy? -> :dev1
      error_type == :unknown and !legacy? -> :dev2
      true -> false
    end
  end
end
