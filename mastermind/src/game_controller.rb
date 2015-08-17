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
			:board => @model.board
		)
		@view.render('form')
		if @model.codebreaker?
			# set board role to codebreaker
			@router.action = :select_guess
		else
			# set board role to codemaker
			@router.action = :select_code
		end
	end

	def over
		@view.render('game')
		@view.render('over')
		@view.render('form')
		@router.action = :menu
	end

	def select_role
		if @model.auth.valid_role?(Input.data)
			@model.role = Input.data
			@router.action = :play
		else
			@router.action = :menu
		end
	end

	def select_code

	end

	def select_guess
		if @model.auth.valid_guess?(Input.data)
			@model.guess = Input.data
		end
		if @model.win? || @model.lose?
			@router.action = :over
		else
			@router.action = :play
		end
	end
end