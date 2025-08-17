#!/usr/bin/env ruby

require 'readline'

class Controller
  def initialize
    @commands = {
      'list' => method(:list_tasks),
      'add' => method(:add_task),
      'delete' => method(:delete_task),
      'quit' => method(:exit_app)
    }
    @tasks = []
  end

  def start
    loop do
      print '> '
      input = Readline.readline('> ', true)
      return if input.nil?
      command, *args = input.split
      if @commands.key?(command)
        @commands[command].call(*args)
      else
        puts "Unknown command: #{command}"
      end
    end
  end

  private

  def list_tasks
    if @tasks.empty?
      puts 'No tasks yet.'
    else
      @tasks.each_with_index { |task, i| puts "#{i + 1}. #{task}" }
    end
  end

  def add_task(*args)
    task = args.join(' ')
    return if task.empty?
    @tasks << task
    puts "Task added: #{task}"
  end

  def delete_task(*args)
    index = args[0].to_i - 1
    return if index < 0 || index >= @tasks.size
    task = @tasks.delete_at(index)
    puts "Task deleted: #{task}"
  end

  def exit_app
    puts 'Goodbye!'
    exit
  end
end

controller = Controller.new
controller.start