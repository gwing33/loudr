# Require any additional compass plugins here.
EXCEPTIONS = [StandardError, ScriptError]

begin
	require "compass-growl"
rescue *EXCEPTIONS
	puts "You don't have compass-growl installed or it isn't running."

	begin
		require "notifompass"	
	rescue *EXCEPTIONS
		puts "You don't have notifompass gem installed either!"
	end
end

# Set this to the root of your project when deployed:
http_path = "/"
# project_path = File.expand_path(File.join(File.dirname(__FILE__), '..'))
project_path = File.expand_path(File.join(File.dirname(__FILE__), '.'))
css_dir = "App/static/css"
sass_dir = "App/assets/sass"
images_dir = "App/static/img"
javascripts_dir = "App/static/js"
fonts_dir = "App/static/fonts"

http_javascripts_dir = "static/js"
http_stylesheets_dir = "static/css"
http_images_dir = "static/img"
http_fonts_dir = "static/fonts"


# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false

preferred_syntax = :sass