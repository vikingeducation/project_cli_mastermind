RSpec.describe Mastermind::GuessAnalyzer do
  example 'without doubles' do
    secret = [:red, :green, :blue, :yellow]
    guess = [:red, :green, :blue, :yellow]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be_zero
    expect(analyzer.exact_matches_count).to be 4
  end

  example 'doubles in the secret' do
    secret = [:blue, :magenta, :magenta, :green]
    guess = [:blue, :magenta, :yellow, :green]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be_zero
    expect(analyzer.exact_matches_count).to be 3
  end

  example 'doubles in the guess' do
    secret = [:blue, :magenta, :yellow, :green]
    guess = [:blue, :blue, :yellow, :green]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be_zero
    expect(analyzer.exact_matches_count).to be 3
  end

  example 'doubles in the guess and the secret' do
    secret = [:blue, :magenta, :blue, :green]
    guess = [:blue, :blue, :yellow, :green]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be 1
    expect(analyzer.exact_matches_count).to be 2
  end

  example '3 the same in the secret' do
    secret = [:yellow, :blue, :blue, :blue]
    guess = [:blue, :magenta, :green, :yellow]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be 2
    expect(analyzer.exact_matches_count).to be_zero
  end

  example '3 the same in the guess' do
    guess = [:yellow, :blue, :blue, :blue]
    secret = [:blue, :magenta, :green, :yellow]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be 2
    expect(analyzer.exact_matches_count).to be_zero
  end

  example '3 the same in the guess and secret' do
    secret = [:yellow, :yellow, :yellow, :magenta]
    guess = [:magenta, :yellow, :yellow, :yellow]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be 2
    expect(analyzer.exact_matches_count).to be 2
  end

  example 'in top of a selected peg' do
    secret = [:green, :green, :magenta, :green]
    guess = [:blue, :magenta, :green, :yellow]
    analyzer = Mastermind::GuessAnalyzer.new(secret, guess)

    expect(analyzer.inexact_matches_count).to be 2
    expect(analyzer.exact_matches_count).to be 0
  end
end
