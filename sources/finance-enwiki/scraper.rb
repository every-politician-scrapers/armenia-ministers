#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Republic of Armenia'
  end

  # TODO: make this easier to override
  def holder_entries
    noko.xpath("//h3[.//span[contains(.,'#{header_column}')]][last()]//following-sibling::ul[1]//li[a]")
  end

  class Officeholder < OfficeholderBase
    def combo_date?
      true
    end

    def startDate
      raw_combo_dates[0]
    end

    def endDate
      raw_combo_dates[1]
    end

    def raw_combo_dates
      noko.text[/\((.*?)\)/, 1].split('-', 2).map(&:tidy).map { |str| str.split('.').reverse.join('-') }
    end

    def name_cell
      noko.css('a')
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
