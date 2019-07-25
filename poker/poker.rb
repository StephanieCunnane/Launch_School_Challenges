# Write a program to pick the best poker hands from a list
#
# No input validation
#
# 1 test - just 1 hand
# Most tests - 2 hands
# Last test - 3 hands, tie for best, return an array of both best hands
#
# There are all sorts of tweaks/variations to poker. Here I just want to focus
# on getting the tests to pass, so I'll ignore something until it affects a
# test.
#
# I've previously written code to score poker hands
# I should use that code and add ranking functionality on top of the
# pre-existing scoring functionality.
#
# This program needs to take input of 1+ already-valid poker hands and return
# the best hand of the given hands. That's it.
#
# A high-level plan:
# 1) Classify
# 2) Compare
#
# I will have the main classification method return a symbol that names the hand
# There will be a constant that is an array of ordered hand symbols:
#    Higher hands have lower indexes (to mimic the way poker hands are ranked in
#    real life)
# Return the hand(s) with the highest index
#
# I have a good start on the classification process from my previous code.
# But my first classification code isn't fine-grained enough for this
# application. I'll need to add to it.
#
################### 
# 
# Let me start by opening up my old code.
# Even before that, let's read the poker hands article.
#
# Hmm, it looks like my classification needs to be more fine-grained than just
# hand type sometimes. Ex: what if there are 2 straight flushes?
#
# A hand is ranked within its category using the ranks of its cards. 
#   (I just returned the category the first time I wrote a poker hand program.)
# Individual cards are ranked, from highest to lowest: A, K, Q, J, 10, 9, 8, 7, 6, 5, 4, 3 and 2.
# Suits are not ranked, so hands that differ by suit alone are of equal rank.
#
# Next step:
#  I'll keep breaking down the problem here rather than diving into my old code
#  just yet.
#  Keep going through the poker article and extracting important information. -
#  DONE
#
# First, get category.
#   If hands are of different categories, we're already done.
# Second, compare ranks within the same category if necessary.
#
# Let me work out the flow of methods I wish existed.
# An #evaluate method that returns a symbol indicating category
#
# What is a good next step?
# I want to see if the flow of the best_hand method works for hands that are of
# differing categories. This is the simpler case.
# Wait, there's an even simpler case - one hand -> return that hand.
# Let's get that working first
# Wait, no. One card actually DOESN'T need to be handled as a special case.
# I can skip handling just one card.
# I'll go straight to adapting my old code
#
# Thoughts on adapting my old code:
# In my current code, there is no concept of a deck. I'm JUST comparing hands.
# I might want a Card class
# In my current code, a card is represented as a 2-char string:
#   - first letter is the rank of the card
#   - second letter is the suit of the card
# This representation is given to me by the test suite, so I can't change it.
# So cards are strings, 5 of which appear in an array to make up a hand.
# There is no point in making a Card class bc I can't represent cards with it.
# On my own, without this test suite, it would also make sense to have a Card
# struct.
#
# Next step:
#   decide how to handle rank and suit for each card:
#     - do I store it anywhere? yes, this is critical info
#     - there's actually nothing saying I can't take the array of card strings
#     and turn it into an array of structs. That will give me access to the info
#     I need. Do this in the initialize method.
#
# Right now I can run the first test to check that I'm correctly initializing
# the hand to an array of Card objects. - DONE
# Wait, let me check it for more than 1 hand. - DONE, working
#
# I'm going to write my program initially with 3 classes:
#   - Card
#   - Hand
#   - Poker
# 
# Now I want to test that I'm initializing the Poker object correctly
# This is working correctly - DONE
# ***Not sure I like the @hand instance variable name
# Symbol to proc
#
# Now I should get each of the helper methods in #categorize working correctly.
# My next big goal is to get the hand_category variable correct in 
# Poker#best_hand. For now, I'm just concerned with the top-level
# categorization, not ranking yet.
#
# I have some debugging to do in the Hand#straight? method.
# 1) Try debugging it myself
# 2) Look at the old LS solution
# 3) re-write the method
#
# I will work with just the first test case to figure this out.
#
# Ok, where am I now? 
# I am correctly categorizing hands
# Now I'm correctly returning the original hand that is the highest hand when
# the categories are different
# So now about half my tests are passing
#
# Now I need to rank them.
# The ranking has 2 cases:
#   1) hands are of different categories - DONE
#       - this is the easier case
#       - I don't have to write much more code to get this working
#       - Let's handle this case -> I'll already have a bunch of passing tests
#   2) hands are of the same categories
#       - where do I want to put the intra-category ranking logic?
#
# Be sure to keep this separated by class:
#   Card
#   Hand
#   Poker (the game class)
#
# This problem was a beast for me, but I did finish it and get 20 of 21 tests
# passing. So I'm proud of myself for that. I'm getting much better at
# methodically breaking down the problem. I also know that I will get to AN
# answer, even if it's not great code yet. 
#
# There's a lot more I can do with this problem.
# 1) Not just refactor, but start again with this problem
# 2) Rewatch video
# 3) Read others' code
# 4) Post my own after I've rewritten it. It's not in a presentable form now.
#    But for now I'm going to move on bc this problem is way harder than what I
#    can expect on the assessment or in a live coding interview.
# 5) Do poker challenges on Codewars
#####################################################################
#
# I'll have 9 categories of hands:
#
#   1) Straight flush (includes royal flush)
#       - ranked by its highest card
#
#   2) Four of a kind
#       - ranked by the quad, then the kicker
#
#   3) Full house
#       - ranked by its triplet, then by its pair
#
#   4) Flush
#       - ranked by its highest card, then next-highest card, then middle card,
#         etc.
#
#   5) Straight
#       - ranked by its highest card
#
#   6) Three of a kind
#       - ranked by its triplet, then higher kicker, then lower kicker
#
#   7) Two pair
#       - ranked by its higher pair, then lower pair, then kicker
#
#   8) One pair
#       - ranked by pair, then kickers (highest to lowest)
#       
#   9) High card
#       - ranked by highest card, then next highest, etc.

# TODO: change this to a Struct
class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

class Hand
  attr_reader :cards

  CATEGORIES = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :one_pair,
    :high_card
  ]

  def initialize(hand)
    @cards = setup_cards(hand)
    @ranks_count = count_ranks
  end

  # returns one of the symbols in CATEGORIES
  def categorize
    case 
    when straight_flush?  then :straight_flush
    when four_of_a_kind?  then :four_of_a_kind
    when full_house?      then :full_house
    when flush?           then :flush
    when straight?        then :straight
    when three_of_a_kind? then :three_of_a_kind
    when two_pair?        then :two_pair
    when one_pair?        then :one_pair
    else                       :high_card
    end
  end

  #private

  def setup_cards(hand)
    hand.map { |card| Card.new(card[0], card[1]) }
  end

  def count_ranks
    ranks_count = Hash.new(0)
    @cards.each { |card| ranks_count[card.rank] += 1 }
    ranks_count
  end

  # these are query methods
  def n_of_a_kind?(n)
    @ranks_count.values.include?(n)
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def flush?
    @cards.map(&:suit).uniq.size == 1
  end

  def straight?
    ranks = @cards.map(&:rank)
    straights = %w(A 2 3 4 5 6 7 8 9 T J Q K A).each_cons(5).to_a.map(&:sort)
    straights.include?(ranks.sort)
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    @ranks_count.values.count(2) == 2
  end

  def one_pair?
    @ranks_count.values.count(2) == 1
  end
end

# Poker is the game class
class Poker
  def initialize(hands)
    @input = hands
    @hands = setup(hands)
  end
  # Pieces:
  #   CATEGORIES
  #   @input
  #   hand_categories
  # Compare hand_categories[idx] to CATEGORIES and return @input[idx]
  # OR
  # sort hand_categories by CATEGORIES and return the first
  # highest_hand = hand_categories.sort_by { |hand_category|
  # CATEGORIES.index(hand_category) }.first
  # return value: @hands[hand_categories.index(highest_hand)]
  # another wrinkle: I need to return the highest hand IN THE SAME FORM AS THE
  # INPUT
  # I'm choosing the highest hand by category, but I need to get the output in
  # the right form

  # the @hands idxs and the hand_categories idxs correspond
  # if hand_categories == hand_categories.uniq
  #    
  # Where should I put the ranking logic? Does that belong in the Hand class? Or
  # the Poker class? The Hand class
  # get_best_straight_flushes - what is the input? 

  # best_hand should push the details of comparing hands to the Hand class
  def best_hand
    hand_categories = @hands.map(&:categorize)
    highest_hand = hand_categories.sort_by { |hand_category| Hand::CATEGORIES.index(hand_category) }.first
    highest_hand_idx = hand_categories.index(highest_hand)

    if hand_categories == hand_categories.uniq
      [@input[highest_hand_idx]]
    elsif hand_categories.count(:straight_flush) == 2
      get_best_straight_flush
    elsif hand_categories.count(:four_of_a_kind) == 2
      get_best_four_of_a_kind
    elsif hand_categories.count(:full_house) == 2
      get_best_full_house
    elsif hand_categories.count(:flush) == 2
      get_best_flush
    elsif hand_categories.count(:straight) == 2
      get_best_straight
    elsif hand_categories.count(:three_of_a_kind) == 2
      get_best_three_of_a_kind
    elsif hand_categories.count(:two_pair) == 2
      get_best_two_pair
    elsif hand_categories.count(:one_pair) == 2
      get_best_one_pair
    else
      get_best_high_card
    end
  end

  private

  def setup(hands)
    hands.map { |hand| Hand.new(hand) }
  end

  # These methods are unwieldy and complicated
  # Is there a way simpler way?
  # I should make more use of sorting
  # Also, Kevin's grouping technique for the hand categorization makes this
  # secondary comparison much easier
  def get_best_straight_flush
    straight_flushes = @hands.select(&:straight_flush?)
    ranks = straight_flushes.map { |hand| hand.cards.map(&:rank) }
    max_rank = ranks.map { |rank_arr| rank_arr.max }.max
    arr_with_max_rank = ranks.select { |rank_arr| rank_arr.include?(max_rank) }.flatten
    just_ranks = @input.map { |hand| hand.map { |card| card[0] } }
    highest_straight_flush_idx = just_ranks.index(arr_with_max_rank) 
    [@input[highest_straight_flush_idx]]
  end

  def get_best_four_of_a_kind
    four_of_a_kinds = @hands.select(&:four_of_a_kind?)
    ranks = four_of_a_kinds.map { |hand| hand.cards.map(&:rank) }
    quad_ranks = ranks.map { |rank_arr| rank_arr.select { |elem| rank_arr.count(elem) == 4 }.first }
    max_quad_rank = quad_ranks.max
    @input.select { |hand| hand.map { |card| card[0] }.count(max_quad_rank) == 4 }
  end

  def get_best_full_house
    full_houses = @hands.select(&:full_house?)
    ranks = full_houses.map { |hand| hand.cards.map(&:rank) }
    triplet_ranks = ranks.map { |rank_arr| rank_arr.select { |elem| rank_arr.count(elem) == 3 }.first }
    max_triplet_rank = triplet_ranks.max
    @input.select { |hand| hand.map { |card| card[0] }.count(max_triplet_rank) == 3 }
  end

  def get_best_flush
    flushes = @hands.select(&:flush?)
    ranks = flushes.map { |hand| hand.cards.map(&:rank) }
    max_rank = ranks.map { |rank_arr| rank_arr.max }.max
    arr_with_max_rank = ranks.select { |rank_arr| rank_arr.include?(max_rank) }.flatten
    just_ranks = @input.map { |hand| hand.map { |card| card[0] } }
    highest_flush_idx = just_ranks.index(arr_with_max_rank)
    [@input[highest_flush_idx]]
  end

  def get_best_straight
    straights = @hands.select(&:straight?)
    ranks = straights.map { |hand| hand.cards.map(&:rank) }
    max_rank = ranks.map { |rank_arr| rank_arr.max }.max
    arr_with_max_rank = ranks.select { |rank_arr| rank_arr.include?(max_rank) }.flatten
    just_ranks = @input.map { |hand| hand.map { |card| card[0] } }
    highest_straight_idx = just_ranks.index(arr_with_max_rank) 
    [@input[highest_straight_idx]]
  end

  def get_best_three_of_a_kind
    three_of_a_kinds = @hands.select(&:three_of_a_kind?)
    ranks = three_of_a_kinds.map { |hand| hand.cards.map(&:rank) }
    triplet_ranks = ranks.map { |rank_arr| rank_arr.select { |elem| rank_arr.count(elem) == 3 }.first }
    max_triplet_rank = triplet_ranks.max
    @input.select { |hand| hand.map { |card| card[0] }.count(max_triplet_rank) == 3 }
  end

  def get_best_two_pair
    two_pairs = @hands.select(&:two_pair?)
    ranks = two_pairs.map { |hand| hand.cards.map(&:rank) }
    pair_ranks = ranks.map { |rank_arr| rank_arr.select { |elem| rank_arr.count(elem) == 2 }.uniq }
    max_pair_rank = pair_ranks.flatten.max
    @input.select { |hand| hand.map { |card| card[0] }.count(max_pair_rank) == 2 }
  end

  def get_best_one_pair
    one_pairs = @hands.select(&:one_pair?)
    ranks = one_pairs.map { |hand| hand.cards.map(&:rank) }
    pair_ranks = ranks.map { |rank_arr| rank_arr.select { |elem| rank_arr.count(elem) == 2 }.uniq }
    max_pair_rank = pair_ranks.flatten.max
    @input.select { |hand| hand.map { |card| card[0] }.count(max_pair_rank) == 2 }
  end

  def get_best_high_card
    ordered_ranks = %w(2 3 4 5 6 7 8 9 T J Q K A)
    ranks = @hands.map { |hand| hand.cards.map(&:rank) }
    max_rank = ranks.flatten.max_by { |rank| ordered_ranks.index(rank) }
    arr_with_max_rank = ranks.select { |rank_arr| rank_arr.include?(max_rank) }.flatten
    #require 'pry'; binding.pry
    just_ranks = @input.map { |hand| hand.map { |card| card[0] } }
    highest_idx = just_ranks.index(arr_with_max_rank) 
    [@input[highest_idx]]
  end
end
