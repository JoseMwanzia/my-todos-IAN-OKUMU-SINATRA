ENV["RACK_ENV"] ||= "development"

require "bundler/setup"
Bundler.require(:default, ENV["RACK_ENV"])

# require_relative "../app/controllers/todo_controller"
# require_relative "../app/models/todos"

require_all "app"