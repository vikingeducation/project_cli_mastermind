class CodeMaker
  COLORS = ["Red", "Grn", "Blu", "Yel", "Brn", "Ong", "Blk", "Wht"]

  def initialize(attrs)
    @ai_maker = attrs[:ai] || true
    @secret_code = []
  end

  def generate_secret_code
    4.times { @secret_code << COLORS.sample }
  end
  
  def get_code
    if @ai_maker
      generate_secret_code
    end
    @secret_code
  end
end