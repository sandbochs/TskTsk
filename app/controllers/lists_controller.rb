class ListsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @lists = current_user.lists
    @list = List.new
  end

  def create
    list_params = params[:list]
    list_params[:user_id] = current_user.id
    list = List.new(list_params)
    
    if list.save
      redirect_to lists_path, notice: "Created list: #{params[:list][:name]}"
    else
      redirect_to lists_path, notice: "Failed to create list."
    end
  end

  def show
    @list = current_user.lists.find(params[:id])
    @todos = @list.todos
    @todo = Todo.new

    @active_todos = @list.todos.active
    @completed_todos = @list.todos.completed

  end

  def edit
    @list = current_user.lists.find(params[:id])
  end

  def update
    list = current_user.lists.find(params[:id])
    list_name = list.name

    if list.update_attributes(params[:list])
      redirect_to lists_path, notice: "Renamed #{list_name} to: #{params[:list][:name]}"
    else
      redirect_to edit_list_path(list), notice: "Failed to rename list:"
    end 
  end

  def destroy
    list = current_user.lists.find(params[:id])
    list_name = list.name
    list.destroy

    if List.exists?(params[:id])
      redirect_to lists_path, notice: "Failed to delete #{list_name}"
    else
      redirect_to lists_path, notice: "Deleted list: #{list_name}"
    end
  end

end
