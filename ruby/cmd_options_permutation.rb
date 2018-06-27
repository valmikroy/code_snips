#!/usr/bin/env ruby

require 'pp'

opts = [
        ['sudo'],
        ['/usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1'],
        ['--membind=0', '--membind=1', '--interleave=all'],
        ['lat_mem_rd'],
        ['4096','51200'],
        ['64','126','200','256','512','1024','10240'],
        ['2>&1']
]

# Above array of array should give you following output
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 4096 64 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 4096 126 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 4096 200 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 4096 256 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 4096 512 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 4096 1024 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 4096 10240 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 51200 64 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 51200 126 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 51200 200 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 51200 256 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 51200 512 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 51200 1024 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=0 lat_mem_rd 51200 10240 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 4096 64 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 4096 126 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 4096 200 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 4096 256 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 4096 512 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 4096 1024 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 4096 10240 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 51200 64 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 51200 126 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 51200 200 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 51200 256 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 51200 512 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 51200 1024 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --membind=1 lat_mem_rd 51200 10240 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 4096 64 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 4096 126 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 4096 200 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 4096 256 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 4096 512 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 4096 1024 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 4096 10240 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 51200 64 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 51200 126 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 51200 200 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 51200 256 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 51200 512 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 51200 1024 2>&1
# sudo /usr/bin/chrt -r 10 taskset -c 1 numactl --physcpubind=1 --interleave=all lat_mem_rd 51200 10240 2>&1


$global_stack = []

$commands = []

def build_cmd(o)
        aa = []
        bb = []
        if o.length > 0
                b = o.shift
                b.each do |x|
                        $global_stack.push(x)
                        build_cmd(o)
                        bb.push($global_stack.pop)
                end
                o.unshift(bb)
        else
                $commands.push($global_stack.clone)
        end
end

build_cmd(opts)

$commands.each do |c|
    puts c.join(' ')
end
