require 'convert_csv_row_to_hash'

RSpec.describe ConvertCsvRowToHash do

  it "should return a hash of values given a valid row" do

    row_sample = [
        "496774793170256000","#sushi #girltime #lunch #dayoff #greenjacket #spicy #5wishes @ Roll One for Mi http://t.co/MBl2SA8Q4q","SanterMsanter71","2279851993","","en","http://pbs.twimg.com/profile_images/422594632036253696/kvEloZw4_normal.jpeg","Fresno, CA.", "", ""
    ]

    row_hash = ConvertCsvRowToHash.convert_row_to_hash(row_sample)

    expect(row_hash[:tweet_user_screen_name]).to eq("SanterMsanter71")

  end

end