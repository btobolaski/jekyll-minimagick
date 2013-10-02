# Automatic Image Resizing for Jekyll #

This gem allows you to easily use MiniMagick to resize your images and
automatically includes an @2x version for use with [retina.js][1]. This is a
forked version of [jekyll-minimagick][2] modified specifically to add the
generation of @2x versions of all of the image sizes. This is very much still a
work in progress. If you would like to help out, make a fork and then submit a
pull request.

Basic Setup
-----------

### Requirements ###

You have to have imagemagick install on your machine. If you are using a mac
and use homebrew, you can install imagemagick by runing `brew install imagemagick`.

### Installation ###

Install the gem:

	[sudo] gem install jekyll-retinamagick

In a plugin file within your Jekyll project's _plugins directory:

	# _plugins/my-plugin.rb
	require "jekyll-retinamagick"

Define presets in your _config.yml file, like this:

	# _config.yml
	retinamagick:
		thumbnail:
			source: img/photos/original
			destination: img/photos/thumbnail
			resize: "100x100"
		medium:
			source: img/photos/original
			destination: img/photos/medium
			resize: "600x400"

This configuration will create a 100x100 thumbnail for each image in
`img/photos/original` and put it in `_site/img/photos/thumbnail`. It will also
generate a 200x200 thumbnail and add an `@2x` between the file name and the
extention. It will also generate a 600x400 and 1200x800 image in a similar way
and then place them in `_site/img/photos/medium`.

Bundler Setup
-------------
Already using bundler to manage gems for your Jekyll project?  Then just add

	gem "jekyll-retinamagick"

to your gemfile and create the following plugin in your projects _plugins
directory.  I've called mine bundler.rb.

    # _plugins/bundler.rb
    require "rubygems"
    require "bundler/setup"
    require "jekyll-imagemagick"

[1]:http://retinajs.com
[2]:https://github.com/zroger/jekyll-minimagick
