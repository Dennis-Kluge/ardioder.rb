require "serialport"

class Dioder

	def initialize(config)
		port_str = config["serial"] 
		baud_rate = 115200 
		data_bits = 8
		stop_bits = 1
		parity = SerialPort::NONE
		@serial_port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

		@channels = [{state: :off, r: "255", g: "255", b: "255"}, {state: :off, r: "255", g: "255", b: "255"}]
	end

	def settings(id)
		@channels[id.to_i]
	end

	def change_color(id, color)
		symbolized_colors = Hash[color.map{ |k, v| [k.to_sym, v] }]
		@channels[id.to_i].merge! symbolized_colors 
		puts "new color: #{@channels[id.to_i]}"
		update
	end

	def switch_on(id) 
		light = @channels[id.to_i]
		light[:state] = :on
		update
	end

	def switch_all_on 
		@channels.each do |c|
			c[:state] = :on
		end
		update
	end

	def switch_off(id) 
		light = @channels[id.to_i]
		light[:state] = :off
		update
	end

	def switch_all_off 
		@channels.each do |c|
			c[:state] = :off 
		end
		update
	end

	def randomize
		@channels.each do |c|
			c[:r] = Random.rand(10 .. 255)
			c[:g] = Random.rand(10 .. 255)
			c[:b] = Random.rand(10 .. 255)
		end
		update
	end

	private

	def update 
		message = "S"
		@channels.each do |c|
			message += convert_colors(c)
		end
		puts "message: #{message}, length: #{message.length}"
		@serial_port.write message
	end

	def convert_colors(channel)
		if channel[:state] == :on
			"#{convert_single_color(channel[:r])}#{convert_single_color(channel[:g])}#{convert_single_color(channel[:b])}"
		else
			"000000000"
		end
	end

	def convert_single_color(color)
		converted_color = color.to_i
		if converted_color == 0
			"000"
		elsif converted_color < 10
			"00#{color}"
		elsif converted_color < 100 
			"0#{color}"
		else
			color	
		end
	end

end