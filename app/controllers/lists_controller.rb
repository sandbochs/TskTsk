class ListsController < ApplicationController

  def index
  end

  def create
  end

  def show
    @list = List.find(params[:id])
    @todos = @list.todos
    @todo = Todo.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
