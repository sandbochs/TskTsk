class TodosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    # Add list_id to params
    todo_params = params[:todo]
    todo_params[:list_id] = params[:list_id]
    todo_params[:user_id] = current_user.id

    list = List.find(params[:list_id])
    @todo = list.todos.new(todo_params)

    if @todo.save
      respond_to do |format|
        format.html { redirect_to list }
        format.js
      end
    else
      redirect_to list, notice: "Failed to create task."
    end
  end

  def edit
    @list = current_user.lists.find(params[:list_id])
    @todo = @list.todos.find(params[:id])
  end

  def update
    todo = current_user.todos.find(params[:id])

    if todo.update_attributes(params[:todo])
      redirect_to list_path(params[:list_id]), notice: "Updated to: #{params[:todo][:description]}"
    else
      redirect_to edit_list_todo_path(params[:list_id], params[:id]), notice: "Failed to update task"
    end
  end

  def destroy
    todo = current_user.todos.find(params[:id])
    todo_description = todo.description
    todo.destroy

    if Todo.exists?(params[:id])
      redirect_to list_path(params[:list_id]), notice: "Failed to delete task: #{todo_description}"
     else
      redirect_to list_path(params[:list_id]), notice: "Deleted task: #{todo_description}"
    end
  end

end
