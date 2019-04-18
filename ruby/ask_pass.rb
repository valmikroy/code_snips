#!/usr/bin/env ruby

require 'pp'
require 'highline/import'


username = 'valmikroy'
password = ask("Enter password: ") { |q| q.echo = false }

puts password
