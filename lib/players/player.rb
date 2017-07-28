module Mastermind
  module Players
    class Player
      attr_reader :name

      def initialize
        set_name
      end

      class << self
        def human(boolean = false)
          @human ||= boolean
        end
      end

      def human?
        self.class.human
      end
    end
  end
end
