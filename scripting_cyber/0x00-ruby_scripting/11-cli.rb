#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

def add_task(task)
  File.open(TASKS_FILE, 'a') do |file|
    file.puts task
  end

  puts "Task '#{task}' added."
end

def list_tasks
  return unless File.exist?(TASKS_FILE)

  File.readlines(TASKS_FILE).each_with_index do |task, index|
    puts "#{index + 1}. #{task.chomp}"
  end
end

def remove_task(index)
  return unless File.exist?(TASKS_FILE)

  tasks = File.readlines(TASKS_FILE)
  removed_task = tasks.delete_at(index.to_i - 1)

  File.open(TASKS_FILE, 'w') do |file|
    tasks.each do |task|
      file.puts task
    end
  end

  puts "Task '#{removed_task.chomp}' removed." if removed_task
end

options = OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'

  opts.on('-a', '--add TASK', 'Add a new task') do |task|
    add_task(task)
  end

  opts.on('-l', '--list', 'List all tasks') do
    list_tasks
  end

  opts.on('-r', '--remove INDEX', 'Remove a task by index') do |index|
    remove_task(index)
  end

  opts.on('-h', '--help', 'Show help') do
    puts opts
  end
end

options.parse!
