class TodosController < ApplicationController

  def create
    # Add list_id to params
    todo_params = params[:todo]
    todo_params[:list_id] = params[:list_id]

    @list = List.find(params[:list_id])
    todo = @list.todos.new

    todo.update_attributes(todo_params)

    if todo.save
      redirect_to @list, notice: "Created task: #{params[:todo][:description]}"
    else
      redirect_to @list, notice: "Failed to create task."
    end
  end

  def edit
    @list = List.find(params[:list_id])
    @todo = @list.todos.find(params[:id])
  end

  def update
    todo = Todo.find(params[:id])

    if todo.update_attributes(params[:todo])
      redirect_to list_path(params[:list_id]), notice: "Updated to: #{params[:todo][:description]}"
    else
      redirect_to edit_list_todo_path(params[:list_id], params[:id]), notice: "Failed to update task"
    end
  end

  def destroy
    id = params[:id]
    todo_description = Todo.find(id).description
    Todo.destroy(id)

    if Todo.exists?(id)
      redirect_to list_path(params[:list_id]), notice: "Failed to delete task: #{todo_description}"
     else
     redirect_to list_path(params[:list_id]), notice: "Deleted task: #{todo_description}"
    end
  end

end
