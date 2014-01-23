

describe WorldCatOclcNumberLink do


  it "returns a link to world cat for the oclc number" do
    expect(WorldCatOclcNumberLink.new('oclc').link).to eq("<a href=\"http://www.worldcat.org/search?q=no%3Aoclc\" target=\"_blank\">World Cat</a>")
  end

  it "if there is no number it returns empty string" do
   expect(WorldCatOclcNumberLink.new('').link).to eq("")
  end

  it "returns empty if the number is nil" do
    expect(WorldCatOclcNumberLink.new(nil).link).to eq("")
  end

end
