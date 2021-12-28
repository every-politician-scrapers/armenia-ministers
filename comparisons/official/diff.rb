#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

# Not listed in the list of ministers, but part of the cabinet
SKIP = [
  ['---', 'Nikol Pashinyan', 'Prime Minister of Armenia']
].freeze

diff = EveryPoliticianScraper::Comparison.new('comparisons/official/wikidata.csv', 'comparisons/official/scraped.csv').diff
                                         .reject { |row| SKIP.include? row }
puts diff.sort_by { |r| [r.first, r[1].to_s] }.reverse.map(&:to_csv)
