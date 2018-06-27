#!/usr/bin/env ruby


require 'pp'

opts = [
        ['./wrk'],
        ['--connections=100','--connections=200','--connections=300','--connections=400','--connections=500'],
        ['','--no_keepalive'],
        ['','--reuse '],
        ['--threads=38 '],
        ['--duration=10 '],
        ['http://web-0001.host:8080/',
         'http://web-0002.host:8080/',
         'https://web-0003.host:8443/',
         'https://web-0004.host:8443/'],
        ['4kb','1mb']
]

$global = []

def build_cmd(a)
        aa = []
        bb = []
        if a.length > 0
                b = a.shift
                b.each do |x|
                        $global.push(x)
                        build_cmd(a)
                        #bb.push($global.pop) if $global.length > 0
                        bb.push($global.pop)
                end
                a.unshift(bb)
        else
                puts $global.join(' ')
        end
end

build_cmd(opts)
