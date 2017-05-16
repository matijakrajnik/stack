defmodule Stack.MainSupervisor do
  use Supervisor
  
  def start_link(initial_state) do
    result = {:ok, supervisor } = Supervisor.start_link(__MODULE__, [initial_state]) 
    {:ok, stash} = Supervisor.start_child(supervisor, worker(Sequence.Stash, [initial_state]))
    Supervisor.start_child(supervisor, supervisor(Sequence.ServerSupervisor, [stash]))
    result
  end
  
  def init(_) do
    supervise [], strategy: :one_for_one
  end
end