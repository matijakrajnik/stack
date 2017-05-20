defmodule Stack.Server do
  use GenServer
  
  @vsn "0"
  
  ### External API
  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
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
  
  ### GenServer implementation
  def init(stash_pid) do
    stack = Stack.Stash.get_stack stash_pid
    { :ok, {stack, stash_pid} }
  end
  
  def handle_call(:pop, _from, {[head | tail], stash_pid}) do
    { :reply, head, {tail, stash_pid} }
  end
  
  def handle_cast({:push, head}, {tail, stash_pid}) do
    { :noreply, {[head | tail], stash_pid} }
  end
  
  def handle_cast({:stop, reason}, stack) do
    { :stop, reason, stack }
  end
  
  def terminate(reason, {stack, stash_pid}) do
    Stack.Stash.stash_stack stash_pid, stack
    IO.puts """
    Server terminated.
    Reason: #{inspect reason}
    Last state: #{inspect stack}
    """
  end
end
