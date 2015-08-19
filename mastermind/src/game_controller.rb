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
		unless @model.code? && @model.codemaker?
			@view.render('colors')
		else
			@view.render('ai')
		end
		@view.render('form')
		if @model.codebreaker?
			@model.code = AI.code unless @model.code?
			@router.action = :select_guess
		elsif ! @model.code?
			@router.action = :select_code
		else
			@router.action = :select_guess
		end
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
		if @model.auth.valid_role?(Input.data)
			@model.role = Input.data
			@router.action = :play
		else
			@router.notice = @model.auth.error
			@router.action = :menu
		end
	end

	def select_code
		if Input.clear?
			@model.clear_code
		else
			if @model.auth.valid_color?(Input.data)
				@model.color = Input.data
			else
				@router.notice = @model.auth.error
			end
		end
		@router.action = :play
	end

	def select_guess
		if Input.clear?
			@model.clear_guesses
		elsif @model.codebreaker?
			if @model.auth.valid_color?(Input.data)
				@model.guess = Input.data
			else
				@router.notice = @model.auth.error
			end
		else
			4.times {@model.guess = AI.color}
		end
		if @model.win? || @model.lose?
			@router.action = :over
		else
			@router.action = :play
		end
	end
end