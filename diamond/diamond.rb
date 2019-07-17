class Diamond
  def self.make_diamond(letter)
    return "A\n" if letter == 'A'

    letters = [*'A'...letter] + [*'A'..letter].reverse
    width = letters.size
    outer = (width / 2).downto(0).to_a + (1..(width / 2)).to_a
    inner = outer.map { |outer| width - 2 - (outer * 2) }

    letters.map.with_index do |letter, idx|
      if letter == 'A'
	'A'.center(width) << "\n"
      else
        "#{' ' * outer[idx]}#{letter}#{' ' * inner[idx]}#{letter}#{' '* outer[idx]}\n"
      end
    end.join
  end
end

# In-video challenge
def generate_pattern(n)
  width = [*1..n].join.size
  n.times do |idx|
    puts (1..idx + 1).to_a.join.ljust(width, "*")
  end
end
