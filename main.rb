require 'tk'

folder = Tk::chooseDirectory
dir = Dir[folder + "/*.txt"]
dir -= ["output.txt"]
Dir.mkdir("output") unless File.exist?("output")
hash = Hash.new

dir.each do |path|
  file = File.open(path, "r:ISO-8859-1:UTF-8")
  wordarray = file.read
  wordarray = wordarray.downcase.gsub(/[^a-z0-9\s]/i, ' ')
  wordarray = wordarray.split(" ")
  hash = wordarray.reduce(Hash.new(0)) do
    |result, vote|
    result[vote] += 1
    result
  end
  file.close
end

file = File.open("./output/output.txt", "w+")
hash = hash.sort_by {|k, v| v}.reverse
hash.each do |k, v|
  file.write("#{k}: #{v} \n")
end