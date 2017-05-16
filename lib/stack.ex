defmodule Stack do
  @initial_state [1, 2, 3, 4, 5]
  use Application
  
  def start(_type \\ [], _args \\ []) do        
    { :ok, _pid } = Stack.MainSupervisor.start_link(@initial_state)
  end
end
