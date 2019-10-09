require 'yaml'
require 'date'

TERM_YEAR_JANUARY_RULE = lambda do |start_date, end_date|
  start_year = start_date.year
  end_year = end_date.year

  end_month = end_date.mon
  end_year -= 1 if end_month == 1
  Range.new(start_year, end_year).to_a
end

def bin_terms(terms, &rule)
  unless block_given?
    rule = lambda do |start_date, end_date|
      Range.new(start_date.year, end_date.year).to_a
    end
  end
  ranges = terms.flat_map do |term|
    start_date = Date.parse(term["start"])
    end_date = Date.parse(term["end"])
    rule.(start_date, end_date)
  end
  ranges.reduce(Hash.new(0)) do |acc, cur|
    acc[cur] += 1
    acc
  end
end

def display_histogram(bins)
  bins.each do |year, count|
    bars = "#" * count
    puts "#{year}: #{bars}"
  end
end

data = YAML.load_file('legislators-current.yaml');

females = data.select { |r| r["bio"]["gender"] == "F"}
terms = females.flat_map do |f|
  f["terms"].select { |t| t["type"] == "rep" }
end
bins = bin_terms(terms)
display_histogram(bins)
# build_term_histogram(terms)
