module NationsHelper
	def webhooks_count(nation)
		if !nation.webhooks_count.nil?
			return nation.webhooks_count
		else
			return 0
		end
	end

	def unitialized_api_style(nation)
		if nation.valid_api == true
			"api-initialized"
		else
			"api-uninitialized"
		end
	end

	def unitialized_api_message(nation)
		if nation.valid_api == true
			nil
		else
			'<p class="center"><em>Looks like this nation\'s API is having issues, please check your nation slug and api credentials.</em></p>'.html_safe
		end
	end

end
