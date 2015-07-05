ARGV.each do |fpath|
	content = IO.read(fpath)

	content.gsub! /\[\[([^\|\[\]]*)\|([^\|\[\]]*)\]\]/ do
		"[#{$1}](/#{$2.gsub(' ', '-')})"
	end

	content.gsub! /\[\[([^\|\[\]]*)\]\]/ do
		"[#{$1}](/#{$1.gsub(' ', '-')})"
	end


	File.write(fpath, content)
end

## TODO: Fix bugs with ODROID-U2/U3 and Gygabyte-GA-E350 (the name cannot contain '()/').
## TODO: Fix bugs with Cubieboard2 page, the page is downcase, the links are uppercase.


require 'redcarpet'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

ARGV.select { |n| File.basename(n)[0] == '_' }.each do |n|
	content = markdown.render(IO.read n)

	File.write("layouts/partials/" + File.basename(n, '.md')[1..-1].downcase + '.html', content)
end

ARGV.each do |fpath|
	content = IO.read(fpath)

	front = "title = \"#{File.basename(fpath, '.md').gsub('-', ' ')}\"\n"
	content = "+++\n" + front + "+++\n" + content

	File.write(fpath, content)
end
