describe impression_pixel_cleaner do
  context "have correct return class" do
    it "returns string" do
      expect(impression_pixel_cleaner('../tactic_sample.csv').class).to eql(String)
    end
  end
end
