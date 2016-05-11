# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not ent1irely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every :day, at:'08:30am'  do
  runner "Plan.check_overtime"
end

every 1.hours do
  runner "Plan.check_overtime"
end
