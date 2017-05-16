defmodule Stack do
  @initial_state [[1, 2, 3, 4, 5]]
  use Application
  
  def start(_type \\ [], _args \\ []) do
    import Supervisor.Spec, warn: false
    
    children = [worker(Stack.Server, @initial_state)]
    options = [strategy: :one_for_one, name: Stack.Supervisor]
    
    { :ok, _pid } = Supervisor.start_link(children, options)
  end
end
