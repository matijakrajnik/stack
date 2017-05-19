defmodule Stack do
  use Application
  
  def start(_type \\ [], _args \\ []) do        
    { :ok, _pid } = Stack.MainSupervisor.start_link(Application.get_env(:stack, :initial_state))
  end
end
