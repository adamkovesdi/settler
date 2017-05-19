#!/usr/bin/env ruby
# balances = { "A" => 10, "B" => -25, "C" => 15,}
# balances = { "A" => 10, "B" => -25, "C" => 20, "E"=>-5}
# balances = { "A" => 10, "B" => -25, "C" => 15, "D"=>0, "E"=>0, }
# balances = { "A" => 13, "B" => -35, "C" => 17, "D"=>30, "E"=>-30, "F"=>-5, "G"=>10 }
# balances = {"A"=>-5,  "B"=>25, "C"=>-20, "D"=>3, "E"=>-2, "F"=>-1, }
balances = { "C"=>-20,"A"=>-5,  "B"=>25, "D"=>3, "E"=>-2, "F"=>-1, }
# balances = { "A"=>9, "B"=>13, "C"=>8, "D"=>-16, "E"=>-14,"F"=>25,"G"=>-10, "H"=>-15}

def eliminate(hash,sol,count,trans)
	if (hash.keys.length<2)
		if (count <= $mincount) && (trans < $maxtrans)
				$maxtrans = trans
				$mincount = count
				$bestsol=sol
		end
		return
	end
	if (count>$mincount)
		return
	end
	if (trans>$maxtrans)
		return
	end

	hash.keys.each do |key1|
		num1=hash[key1]
		nhash = hash.clone
		nhash.delete(key1)
		nhash.keys.each do |key2|
			nsol = sol.clone
			if hash[key1].positive? && hash[key2].negative?
				nsol.concat("#{key2}->#{key1} #{num1.abs}|")
			elsif hash[key1].negative? && hash[key2].positive?
				nsol.concat("#{key1}->#{key2} #{num1.abs}|")
			end
			fhash = nhash.clone
			fhash[key2]+=num1
			fhash.delete_if { |k,v| v==0}
			eliminate(fhash,nsol,count+1,trans+num1.abs)
		end
	end
end

def resolve_settlement(hash)
	hash.delete_if { |k,v| v==0}
	$mincount = hash.keys.length
	$maxtrans = 0
	sum = 0
	hash.values.each do |val|
		$maxtrans += val.abs
		sum += val
	end
	unless sum == 0
		puts " *** fatal error nonzero sum #{sum}"
		return
	end
	sol = String.new
	eliminate(hash,sol,0,0)
	puts $bestsol
end

load 'generate.rb'
balances = create_expenses(6)
puts balances
resolve_settlement(balances)

