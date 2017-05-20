defmodule StackServerTest do
  use ExUnit.Case
  doctest Stack.Server
  @initial_state Application.get_env(:stack, :initial_state)
  @new_element 123
  
  import Stack.Server, only: [pop: 0, push: 1]
  
  setup do
    :sys.replace_state(Stack.Server, fn {_old_state, pid} -> {@initial_state, pid} end)
    :ok
  end
  
  test "server started with initial state" do
    {server_state, pid} = :sys.get_state(Stack.Server)
    assert server_state == @initial_state
    assert pid != nil
  end
  
  test "pop from stack server" do
    {poped_element, new_list} = List.pop_at(@initial_state, 0)
    assert pop() == "Stack returned: #{poped_element}"
    {poped_element, _} = List.pop_at(new_list, 0)
    assert pop() == "Stack returned: #{poped_element}"
  end
  
  test "push to stack server" do
    assert push(@new_element) == :ok
    {server_state, _pid} = :sys.get_state(Stack.Server)
    assert server_state == [@new_element | @initial_state]
  end
end
