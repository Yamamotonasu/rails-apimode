class TodosController < ApplicationController
  include ExceptionHandler
  include Response
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todo = Todo.all
    json_response(@todo)
  end

  def create
    @todo = Todo.create!(todo_params)
    json_response(@todo, created)
  end

  def show
    json_response(@todo)
  end

  def update
    @todo.update(todo_params)
  end

  def destroy
    @todo.destroy
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
