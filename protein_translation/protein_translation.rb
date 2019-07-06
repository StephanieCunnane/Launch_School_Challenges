# n method first
# input - one 3-letter string representing a codon
# output - one string representing the amino acid that corresponds to the given
# codon OR an InvalidCodonError
# rules:
#     explicit requirements
#         each of the 17 codons corresponds to an amino acid OR to STOP
#         if a STOP codon is reached, we terminate translation
#         raise InvalidCodonError if the given string is not all codons

# mental model:
#
# a CODON_TO_AMINO_ACID hash
# 
#class InvalidCodonError < RuntimeError; end
#
#class Translation
#  CODON_TO_AMINO_ACID = {
#    'AUG' => 'Methionine',
#    'UUU' => 'Phenylalanine',
#    'UUC' => 'Phenylalanine',
#    'UUA' => 'Leucine',
#    'UUG' => 'Leucine',
#    'UCU' => 'Serine',
#    'UCC' => 'Serine',
#    'UCA' => 'Serine',
#    'UCG' => 'Serine',
#    'UAU' => 'Tyrosine',
#    'UAC' => 'Tyrosine',
#    'UGU' => 'Cysteine',
#    'UGC' => 'Cysteine',
#    'UGG' => 'Tryptophan',
#    'UAA' => 'STOP',
#    'UAG' => 'STOP',
#    'UGA' => 'STOP'
#  }
#
#  def self.of_codon(codon)
#    raise InvalidCodonError unless CODON_TO_AMINO_ACID[codon]
#    CODON_TO_AMINO_ACID[codon]
#  end
#
#  def self.of_rna(strand)
#    amino_acids = []
#    codons = strand.scan(/[UAGC]{3}/)
#    raise InvalidCodonError if codons.empty?
#
#    codons.each do |codon|
#      return amino_acids if of_codon(codon) == 'STOP'
#      amino_acids << of_codon(codon)
#    end
#
#    amino_acids
#  end
#end

#class InvalidCodonError < RuntimeError; end
#
#class Translation
#  CODON_TO_AMINO_ACID = {
#    AUG: 'Methionine',
#    UUU: 'Phenylalanine',
#    UUC: 'Phenylalanine',
#    UUA: 'Leucine',
#    UUG: 'Leucine',
#    UCU: 'Serine',
#    UCC: 'Serine',
#    UCA: 'Serine',
#    UCG: 'Serine',
#    UAU: 'Tyrosine',
#    UAC: 'Tyrosine',
#    UGU: 'Cysteine',
#    UGC: 'Cysteine',
#    UGG: 'Tryptophan',
#    UAA: 'STOP',
#    UAG: 'STOP',
#    UGA: 'STOP'
#  }
#
#  def self.of_codon(codon)
#    raise InvalidCodonError unless CODON_TO_AMINO_ACID[codon.to_sym]
#    CODON_TO_AMINO_ACID[codon.to_sym]
#  end
#
#  def self.of_rna(strand)
#    amino_acids = []
#    codons = strand.scan(/[UAGC]{3}/).map(&:to_sym)
#    raise InvalidCodonError if codons.empty?
#
#    codons.each do |codon|
#      return amino_acids if of_codon(codon) == 'STOP'
#      amino_acids << of_codon(codon)
#    end
#
#    amino_acids
#  end
#end

class InvalidCodonError < ArgumentError; end

class Translation
  CODON_TO_AMINO_ACID = {
    'AUG' => 'Methionine',
    'UUU' => 'Phenylalanine',
    'UUC' => 'Phenylalanine',
    'UUA' => 'Leucine',
    'UUG' => 'Leucine',
    'UCU' => 'Serine',
    'UCC' => 'Serine',
    'UCA' => 'Serine',
    'UCG' => 'Serine',
    'UAU' => 'Tyrosine',
    'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine',
    'UGC' => 'Cysteine',
    'UGG' => 'Tryptophan',
    'UAA' => 'STOP',
    'UAG' => 'STOP',
    'UGA' => 'STOP'
  }.freeze

  def self.of_codon(codon)
    CODON_TO_AMINO_ACID.fetch(codon) { raise InvalidCodonError }
  end

  def self.of_rna(strand)
    strand.scan(/.../).each_with_object([]) do |codon, amino_acids|
      return amino_acids if of_codon(codon) == 'STOP'
      amino_acids << of_codon(codon)
    end
  end
end
