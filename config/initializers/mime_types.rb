# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
#
# tell Rack (and Sprockets) about modern font MIME types:
Rack::Mime::MIME_TYPES['.ttf'] = 'application/x-font-ttf'
Rack::Mime::MIME_TYPES['.eot'] = 'application/x-font-eot'
Rack::Mime::MIME_TYPES['.otf'] = 'application/x-font-otf'
Rack::Mime::MIME_TYPES['.woff'] = 'application/x-font-woff'
