require 'json'
require 'csv'

# def is_int(str)
#   # Check if a string should be an integer
#   return !!(str =~ /^[-+]?[1-9]([0-9]*)?$/)
# end

file_name = "expenses.csv"

json = CSV.open(file_name, headers: true).map do |row|
  modifier = {}
  row.each do |k, v|
    if k =~ /modifier(.)_(.*)$/
      (modifier[$1] ||= {})[$2] = v
    end
  end
  { politician: row['Politician'],
  	party: row['Party'],
  	total: row['Total']
  }
end

json_update = json.sort_by{|s| s[:party] }.group_by { |s| s[:party] }.map {|k,v| {"name" => k, "children" => v }}


begin
  file = File.open("#{file_name}.json", "w")
  file.write(json_update.to_json)
rescue IOError => e
  #some error occur, dir not writable etc.
ensure
  file.close unless file == nil
end



# csv = CSV.open(file_name, headers: true, header_converters: :symbol, converters: :all).to_a.map(&:to_hash)
# jsonFile = File.open("#{file_name}.json","w") {|f| f.write( )}
# jsonData = {}


# {|f| w.write(csv) }
