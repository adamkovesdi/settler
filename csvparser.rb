#!/usr/bin/env ruby
require 'csv'

def csv_to_hash(csvfile,hash)
	CSV.foreach("input1.csv", col_sep: ',', row_sep: :auto, headers: false) do |row|
		hash.store(row[0],row[1])
	end
end

