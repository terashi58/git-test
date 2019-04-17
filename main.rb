#!/usr/bin/env ruby

require 'zlib'

def parse(data)
  raw = Zlib::Inflate.new.inflate(data)
  header, contents = raw.split("\x00", 2)
  type, size = header.split(" ", 2)
  [type, size.to_i, contents]
end

def find_file(hash)
  return STDIN unless hash
  path = ".git/objects/#{hash[0...2]}/#{hash[2..-1]}"
  open(path)
end

puts parse(find_file(ARGV[0]).read)
