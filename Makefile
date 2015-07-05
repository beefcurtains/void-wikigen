site: content
	ruby precompile.rb content/*.md
	hugo
	cp public/Home/index.html public/index.html

serve:
	darkhttpd public --port 8118

content:
	git clone https://github.com/voidlinux/documentation.wiki.git content


clean:
	rm -rf content
	git clean -fdx
