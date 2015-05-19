namespace :sessions do
  desc "Deletes all expired sessions and sets any sessionless users offline."
  task :purge => :environment do
    puts "Purging sessions..."
    Session.expired.destroy_all
    puts "Done."
  end
end
