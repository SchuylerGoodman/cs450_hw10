english_freq = tdfread('english_freq.tsv', ',');
letters = english_freq.letter;
frequencies = english_freq.frequency;

elements = frequencies.* log2(frequencies);
entropy = -1 * sum(elements)