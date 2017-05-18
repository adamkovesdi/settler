#!/usr/bin/env ruby

load "generate.rb"

$tolerance = 500

balances = Hash.new
aftermatch = Hash.new

balances = create_expenses

def findmatch_recurse(hash,remaining)
	if hash.empty? then return end
	elem = hash.shift
	value = elem[1]
	matching = hash.select { |k,v| (v > ((value*-1)-$tolerance/2)) && (v < ((value*-1)+$tolerance/2)) }
	unless matching.empty?
		puts " #{elem[0]} #{value} <-> #{matching.keys[0]} #{matching.values[0]}"
		hash.delete(matching.keys.pop)
	else
		remaining.store(elem[0],elem[1])
	end
	findmatch_recurse(hash,remaining)
end

def deduct(aftermatch)
	while aftermatch.keys.length > 1 do
		namemin = aftermatch.min_by{|k,v| v}.shift
		valmin = aftermatch[namemin]
		namemax = aftermatch.max_by{|k,v| v}.shift
		valmax = aftermatch[namemax]

		if ((valmin.abs < $tolerance) || (valmax.abs < $tolerance) )
			puts "Insignificant amount #{valmin.abs}"
			aftermatch.delete(namemin)
		else
			print " #{namemin} -> #{namemax} "
			if valmin.abs < valmax.abs
				puts valmin.abs 
				aftermatch[namemax] -= valmin.abs
				aftermatch.delete(namemin)
			else
				puts valmax.abs 
				aftermatch[namemin] += valmax.abs
				aftermatch.delete(namemax)
			end
			aftermatch.delete_if {|k,v| v==0}
		end
	end
end

puts balances
# puts "Tolerance is #{$tolerance}"
findmatch_recurse(balances,aftermatch)
deduct(aftermatch)
