API_KEY = ENV["API_KEY"]
NATION_SLUG = ENV["NATION_SLUG"]

if Rails.env.production?
	API_ENCRYPTION = { ENV["API_KEY_1"] => ENV["API_VALUE_1"],
				   ENV["API_KEY_2"] => ENV["API_VALUE_2"],
				   ENV["API_KEY_3"] => ENV["API_VALUE_3"],
				   ENV["API_KEY_4"] => ENV["API_VALUE_4"],
				   ENV["API_KEY_5"] => ENV["API_VALUE_5"],
				   ENV["API_KEY_6"] => ENV["API_VALUE_6"],
				   ENV["API_KEY_7"] => ENV["API_VALUE_7"],
				   ENV["API_KEY_8"] => ENV["API_VALUE_8"],
				   ENV["API_KEY_9"] => ENV["API_VALUE_9"],
				   ENV["API_KEY_10"] => ENV["API_VALUE_10"],
				   ENV["API_KEY_11"] => ENV["API_VALUE_11"],
				   ENV["API_KEY_12"] => ENV["API_VALUE_12"],
				   ENV["API_KEY_13"] => ENV["API_VALUE_13"],
				   ENV["API_KEY_14"] => ENV["API_VALUE_14"] }
end