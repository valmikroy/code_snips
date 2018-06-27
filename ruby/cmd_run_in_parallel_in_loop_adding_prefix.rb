#!/usr/bin/env ruby
require 'pty'


# commands which run in their own loop
cmds = [
        ['sar_dev', 'sar -n DEV 1'],
        ['sar_edev', 'sar -n EDEV 1'],
        ['sar_tcp', 'sar -n TCP 1'],
        ['sar_etcp', 'sar -n ETCP 1'],
        ['sar_sock', 'sar -n SOCK 1'],
        ['mpstat_irq','mpstat -I SCPU 1'],
        ['mpstat_cpu','mpstat -P ALL 1']
]

# command which need to be executed on regular interval
loop_cmds = [
        ['softnet_stat','rx_packet_optimization/scripts/softnet/softnet-stat']
]



# This function to consume @cmds
def shell_execute(caption,cmd)
  PTY.spawn( cmd ) do |stdout, stdin, pid|
    begin
      stdout.each do  |line|
	# append timestamp for each line
        ts = Time.now.strftime("%s")
        print "timestamp=#{ts} id=#{ENV['RUN_ID']}\ttype=#{caption}\t\t#{line}"
      end
    rescue Errno::EIO
        sleep 1
    end
  end
end


# This function to consume @loop_cmds
def loop_shell_execute(caption,cmd)
        loop { shell_execute(caption,cmd); sleep 1  }
end


# Adding start time as unique ID for a run
ENV['RUN_ID'] = Time.now.strftime("%Y%m%d%H%M%S")
  


# create threads
begin
	threads = []
	cmds.each do |c|
		threads << Thread.new do
			shell_execute(c[0],c[1])
		end

	end

	loop_cmds.each do |c|
		threads << Thread.new do
			loop_shell_execute(c[0],c[1])
		end
	end
	threads.each { |thr| thr.join }

rescue PTY::ChildExited
  puts "The child process exited!"
end  
