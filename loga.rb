
QUERY_FILE_CONTENT = "-r"
does_query_content = ARGV.include?(QUERY_FILE_CONTENT)

def get_keywords(keywords)
  return Regexp.new(keywords)
end

def collect_keywords
  args = ARGV.select {|a| a != QUERY_FILE_CONTENT }
  (args|| []).join(".*")
end

def collect_keywords_ext
		"[^\n]+#{collect_keywords}.+\n.+[^\n]+"
end

keywords = get_keywords(collect_keywords)

if ARGV.size == 0
    abort("arguments missing")
end

puts "query_content?: #{does_query_content} keywords: #{keywords}"

def log_files
        Dir["./**/*.as"].select { |f| File.file?(f) }
end

results = []

def target?(regex, line)
    regex =~ line
end

if does_query_content
    log_files
	    .select { |file| keywords =~ File.read(file, encoding: "utf-8") }
	    .each   { |file| 
			puts file
			puts get_keywords(collect_keywords_ext)
			         .match(File.read(file, encoding: "utf-8"))
			puts "-------------------------------------------"
	    }
else
    puts log_files.select { |file| keywords =~ file }
end


# f = File.open("result.txt", "w")
# 
# log_files.each do |log_file|
#     File.open(log_file, "r")
#         .select {|line| target?(keywords, line) }
#         .each { |line|
#               f.puts log_file + " | " + line
#             results.push(line)
#         }
# end
# 
# f.puts results.size
# f.close
