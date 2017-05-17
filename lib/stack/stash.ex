defmodule Stack.Stash do
  use GenServer
  
  ### External API
  def start_link(stack) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stack)
  end
  
  def stash_stack(pid, stack) do
    GenServer.cast(pid, {:stash_stack, stack})
  end
  
  def get_stack(pid) do
    GenServer.call(pid, :get_stack)
  end
  
  ### GenServer implementation
  def handle_cast({:stash_stack, stack}, _current_stack) do
    { :noreply, stack }
  end
  
  def handle_call(:get_stack, _from, current_stack) do
    { :reply, current_stack, current_stack }
  end
end