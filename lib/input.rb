# Contains a method for getting yes/no input from the user
module Input
  def self.confirmation?(message)
    answer = ''
    loop do
      print message
      answer = gets.chomp

      break if %w[y n].include?(answer) # rubocop:disable Performance/CollectionLiteralInLoop
    end

    answer == 'y'
  end
end
