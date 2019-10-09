require 'rspec'
require_relative 'interview_kata'

RSpec.describe "yay" do
  describe "years rules" do
    let(:terms) do
      [
        {
          "start" => '1993-01-05',
          "end" => '1995-01-03'
        },
        {
          "start" => '1995-01-04',
          "end" => '1997-01-03'
        },
      ]
    end

    context "naive counting, without a rule" do
      it "builds a hash of years and counts" do
        expect(bin_terms(terms)).to eq ({
          1993 => 1,
          1994 => 1,
          1995 => 2,
          1996 => 1,
          1997 => 1
        })
      end
    end

    context "with our rule" do
      it "builds a hash of years and counts" do
        expect(bin_terms(terms, &TERM_YEAR_JANUARY_RULE)).to eq ({
          1993 => 1,
          1994 => 1,
          1995 => 1,
          1996 => 1,
        })
      end

    end


  end
end