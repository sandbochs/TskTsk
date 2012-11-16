class ListsController < ApplicationController

  def index
    @lists = List.all
    @list = List.new
  end

  def create
    list = List.new
    list.update_attributes(params[:list])

    if list.save
      redirect_to lists_path, notice: "Created list: #{params[:list][:name]}"
    else
      redirect_to lists_path, notice: "Failed to create list."
    end
  end

  def show
    @list = List.find(params[:id])
    @todos = @list.todos
    @todo = Todo.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list_name = list.name

    if list.update_attributes(params[:list])
      redirect_to lists_path, notice: "Renamed #{list_name} to: #{params[:list][:name]}"
    else
      redirect_to edit_list_path(list), notice: "Failed to rename list:"
    end 
  end

  def destroy
    id = params[:id]
    list_name = List.find(id).name
    List.destroy(id)

    if List.exists?(id)
      redirect_to lists_path, notice: "Failed to delete #{list_name}"
    else
      redirect_to lists_path, notice: "Deleted list: #{list_name}"
    end
  end

end
