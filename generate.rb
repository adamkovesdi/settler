#!/usr/bin/env ruby


def generate(output)
	names = ["Sanyi","Beno","Geza","Judit","Tivadar","Lilla","Matyi","Gizi","Klari","Cilike","Janos","Marci","Botond","Zita","Aniko"]
	names.shuffle!
	sum = 0
	7.times do
		szam = Random.rand(-20000..30000)
		output.store(names.pop,szam)
		sum += szam
	end
	output.store(names.pop,sum*-1)
	sum.abs
end

def create_expenses()
	output = Hash.new
	while generate(output)>1500 do
		output.clear
	end
	output
end

# output = Hash.new
# output =  create_expenses
# output.keys.each { |k| puts "#{k},#{output[k]}" }
