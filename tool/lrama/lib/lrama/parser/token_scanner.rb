module Lrama
  class Parser
    class TokenScanner
      def initialize(tokens)
        @tokens = tokens
        @index = 0
      end

      def current_token
        @tokens[@index]
      end

      def current_type
        current_token && current_token.type
      end

      def next
        token = current_token
        @index += 1
        return token
      end

      def consume(*token_types)
        if token_types.include?(current_type)
          token = current_token
          self.next
          return token
        end

        return nil
      end

      def consume!(*token_types)
        consume(*token_types) || (raise "#{token_types} is expected but #{current_type}. #{current_token}")
      end

      def consume_multi(*token_types)
        a = []

        while token_types.include?(current_type)
          a << current_token
          self.next
        end

        raise "No token is consumed. #{token_types}" if a.empty?

        return a
      end

      def eots?
        current_token.nil?
      end
    end
  end
end
