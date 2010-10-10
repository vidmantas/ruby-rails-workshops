require 'rubygems'
require 'rufus/scheduler'
require 'eventmachine'

class PeriodicTasks
  attr_accessor :scheduler, :counter
  
  def initialize
    @scheduler = Rufus::Scheduler.start_new

    def scheduler.handle_exception (job, exception)
      puts "#{Time.now}: Job #{job.job_id} caught exception #{exception.inspect}"
    end
  end

  def self.run
    EventMachine::run do
      puts "#{Time.now}: running!"
      self.new.schedule
    end
  end

  def schedule
    
    @scheduler.at "#{Time.now + 10}", :tags => "job_at" do
      puts "#{Time.now}: 10 seconds have passed since start!"
    end
    
    @scheduler.in "30s", :blocking => true, :tags => "job_in" do
      puts "#{Time.now}: I am blocking!"
      20.times do |i|
        puts i
        sleep(1)
      end
      puts "#{Time.now}: Not blocking anymore!"
    end
    
    @scheduler.every "10s", :timeout => "5s", :tags => "job_every" do |job|
      random_sleep = rand(2) * 2 + 4
      puts "#{Time.now}: Job #{job.job_id} will "  + (random_sleep <= 5 ? "talk again in #{random_sleep} seconds!" : "get timeout (#{random_sleep})")
      sleep(random_sleep)
      puts "#{Time.now}: Job #{job.job_id} talking again!"
    end
    
    @scheduler.cron '*/1 * * * *', :tags => "job_cron" do
      @counter ||= 0
      puts "#{Time.now}: Every minute cron job!"
      every_jobs = scheduler.find_by_tag('job_every').map(&:job_id)
      if counter == 0
        puts "#{Time.now}: Every job: #{every_jobs}"
        @counter += 1
      else
        every_jobs.each do |ej|
          puts "#{Time.now}: Unscheduling #{ej}"
          scheduler.unschedule(ej)
        end
      end
    end
    
  end
end

PeriodicTasks.run
