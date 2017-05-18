#!/usr/bin/env ruby

tolerance = 500

balances = Hash.new

balances["Jeno"]= 4980
balances["Geza"]= -2450
balances["Cecil"]= 7900
balances["Gabi"]= -12765
balances["Miki"]= 2335
balances["Senki"]= 4870
balances["Mas"]= -4870
# balances["Fama"]= -4870

sum = 0
balances.each do |name,bal|
	sum += bal
end

if sum != 0
	puts " *** Fatal error: total amount should be zero instead of #{sum}. Exiting."
	return
end

puts balances
balances.delete_if {|k,v| v==0}
puts

while balances.keys.length > 1 do
	namemin = balances.min_by{|k,v| v}.shift
	valmin = balances[namemin]
	namemax = balances.max_by{|k,v| v}.shift
	valmax = balances[namemax]

	if ((valmin.abs < tolerance) || (valmax.abs < tolerance) )
		puts "Insignificant amount #{valmin.abs}"
		balances.delete(namemin)

	else
	
	print "Transaction #{namemin} -> #{namemax} "
	if valmin.abs < valmax.abs
		puts valmin.abs 
		balances[namemax] -= valmin.abs
	 	balances.delete(namemin)
	else
		puts valmax.abs 
		balances[namemin] += valmax.abs
		balances.delete(namemax)
	end
	balances.delete_if {|k,v| v==0}
	end

end
