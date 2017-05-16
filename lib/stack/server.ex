defmodule Stack.Server do
  use GenServer
  
  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end
  
  def pop() do
    GenServer.call(__MODULE__, :pop)
  end
  
  def push(new_number) do
    GenServer.cast(__MODULE__, {:push, new_number})
  end
  
  def shutdown(reason \\ :shutdown) do
    GenServer.cast(__MODULE__, {:stop, reason})
  end
  
  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end
  
  def handle_cast({:push, head}, tail) do
    { :noreply, [head | tail] }
  end
  
  def handle_cast({:stop, reason}, stack) do
    { :stop, reason, stack }
  end
  
  def terminate(reason, stack) do
    IO.puts """
    Server terminated.
    Reason: #{reason}
    Last state: #{inspect stack}
    """
  end
end