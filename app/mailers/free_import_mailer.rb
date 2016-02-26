class FreeImportMailer < ApplicationMailer
	default from: "kevinjamescoleman.7@gmail.com"

	def trello_notication_email(board_name, card_name, creator)
		@board_name = board_name
  	@card_name = card_name
  	@creator = creator
  	mail(to: "coleman@nationbuilder.com", subject: "New card on #{@board_name}")
  end
end
