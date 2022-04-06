#!/bin/bash

bundle exec ruby comparisons/official/scraper.rb > comparisons/official/scraped.csv
bundle exec ruby comparisons/official/wikidata.rb meta.json | sed -e 's/T00:00:00Z//g' | qsv dedup -s psid > comparisons/official/wikidata.csv
bundle exec ruby comparisons/official/diff.rb | tee comparisons/official/diff.csv
