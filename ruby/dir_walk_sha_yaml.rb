#!/usr/bin/env ruby

require 'digest'
require 'yaml'

@d = Hash.new

def a(path)
  x = Digest::SHA256.file path
  sha1 = x.hexdigest
  @d[path.gsub(/\.\//,'')] = sha1
end

def walk(d)
  Dir.foreach(d) do |x|
    next if x == '.'  || x == '..'
    path = "#{d}/#{x}"
    walk(path) if File.directory?(path)
    next  if File.directory?(path)
    a(path)
  end
end





walk('.')
puts @d.to_yaml
