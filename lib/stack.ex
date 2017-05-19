defmodule Stack do
  use Application
  
  def start(_type \\ [], initial_state \\ []) do        
    { :ok, _pid } = Stack.MainSupervisor.start_link(initial_state)
  end
end
