class PegSet
  attr_reader :exactly_matched, :partially_matched, :unmatched
  
  def initialize(args)
    @exactly_matched = args[:exactly_matched]
    @partially_matched = args[:partially_matched]
    @unmatched = args[:unmatched]
  end
  
  def to_s
     "●" * exactly_matched + "○" * partially_matched + "·" * unmatched
  end
  
  def winning?
    @unmatched == 0 && @partially_matched == 0
  end
end