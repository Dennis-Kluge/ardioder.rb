require "sinatra"
require "json"
require "psych"
require_relative "lib/dioder.rb"

config = Psych.load(File.open("config.yml"))
app_config = config["app"]
dioder = Dioder.new(config["dioder"])

set :port, app_config["port"]

get "/" do
	erb :index
end

get "/light/:id.json" do
	dioder.settings(params[:id]).to_json
end

post "/light/on" do
	dioder.switch_all_on
	status 200
end

post "/light/off" do
	dioder.switch_all_off
	status 200
end

post "/light/random" do
	dioder.randomize
	status 200
end

post "/light/:id/color" do
	dioder.change_color(params[:id], JSON.parse(params[:data]))
	status 200
end

post "/light/:id/on" do
	dioder.switch_on(params[:id])
	status 200
end

post "/light/:id/off" do
	dioder.switch_off(params[:id])
	status 200
end

