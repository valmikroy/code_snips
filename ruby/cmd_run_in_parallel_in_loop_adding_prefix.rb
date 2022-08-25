#!/usr/bin/env ruby

require 'open3'


# commands which run in their own loop
cmds = [
        ['sar_dev', 'sar -n DEV 1'],
        ['sar_edev', 'sar -n EDEV 1'],
        ['sar_tcp', 'sar -n TCP 1'],
        ['sar_etcp', 'sar -n ETCP 1'],
        ['sar_sock', 'sar -n SOCK 1'],
        ['mpstat_irq','mpstat -I SCPU 1'],
        ['mpstat_cpu','mpstat -P ALL 1'],
        ['sar_mem','sar -r 1'],
        ['sar_page','sar -B 1'],
        ['sar_block_1','sar -b 1'],
        ['sar_block_2','sar -d 1']
]

# command which need to be executed on regular interval
loop_cmds = [
        ['softnet_stat','/home/ec2-user/softnet-stat'],
        ['socket_mem_sum','/home/ec2-user/sum_netsocket_mem.sh']
]



# This function to consume @cmds
def shell_execute(caption,cmd)

  Open3.popen2e('sh', '-c', cmd) do |i,oe,t|
    oe.each { |line| puts  "timestamp=#{Time.now.strftime("%s")} id=#{ENV['RUN_ID']}\ttype=#{caption}\t\t#{line}"  }
  end

end


# This function to consume @loop_cmds
def loop_shell_execute(caption,cmd)
        loop { shell_execute(caption,cmd); sleep 1  }
end


# Adding start time as unique ID for a run
ENV['RUN_ID'] = Time.now.strftime("%Y%m%d%H%M%S") if ENV['RUN_ID'].nil?



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

rescue SystemExit => e
  puts "The child process exited!"
end
