API_KEY = ENV["API_KEY"]
NATION_SLUG = ENV["NATION_SLUG"]

if Rails.env.production?
	API_ENCRYPTION = JSON.parse ENV["API_ENCRYPTION"].gsub('=>', ':')
end