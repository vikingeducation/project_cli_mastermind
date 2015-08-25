class GameController < Controller
	def menu
		@view.render('game')
		@view.render('menu')
		@view.render('form')
		@router.action = :select_role
	end

	def play
		@view.render('game')
		@view.render('play',
			:board => @model
		)
		@view.render(form_message)
		@view.render('form')
		@router.action = :select_guess
		@router.action = :select_code unless @model.code?
	end

	def over
		@view.render('game')
		@view.render('play')
		result = @model.win? ? 'win' : 'lose'
		@view.render('over', :result => result)
		@view.render('form')
		@router.action = :menu
		@model.clear
	end

	def select_role
		@model.role = Input.data
		if @model.role?
			@router.action = :play
		else
			Input.notice = @model.validation.error
			@router.action = :menu
		end
	end

	def select_code
		auto_code if @model.codebreaker?
		player_code if @model.codemaker?
		@router.action = :play
	end

	def select_guess
		auto_guess if @model.codemaker?
		player_guess if @model.codebreaker?
		@router.action = :play
		@router.action = :over if @model.win? || @model.lose?
	end

	private
		def form_message
			if @model.codebreaker?
				return @model.code? ? 'colors' : 'thinking'
			else
				return @model.code? ? 'thinking' : 'colors'
			end
		end

		def auto_code
			@model.code = AI.code
		end

		def player_code
			@model.code = Input.data
			if Input.clear?
				@model.clear_code
			elsif ! @model.code?
				Input.notice = @model.validation.error
			end
		end

		def auto_guess
			@model.guess = AI.guess
		end

		def player_guess
			@model.guess = Input.data
			if Input.clear?
				@model.clear_guesses
			elsif ! @model.guess?
				Input.notice = @model.validation.error
			end
		end
end