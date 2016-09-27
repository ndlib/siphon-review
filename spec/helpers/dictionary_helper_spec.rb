
RSpec.describe DictionaryHelper do

  let(:test_class) { Class.new { include DictionaryHelper } }

  let(:test_dict) do
    {
      "string_key" => "string_val",
      symbol: :symb,
      7 => 54,
      dict: {
        k: :v
      },
      array: [1, 2, 3],
      nil_key: nil,
    }
  end

  def ret_vals(unchecked, checked)
    return {
      unchecked: unchecked,
      checked: checked
    }
  end

  def expect_eq(got, expected)
    expect(got[:checked]).to eq(expected)
    expect(got[:unchecked]).to eq(expected)
  end

  def get_suit(key, default)
    get_val = test_class.get(test_dict, key, default)
    checked_val = test_class.get_checked(test_dict, key, default)

    expect(get_val).to eq(checked_val)
    ret_vals(get_val, checked_val)
  end

  def hierarchy_suit(keys, default)
    get_val = test_class.get_hierarchy(test_dict, keys, default)
    checked_val = test_class.get_hierarchy_checked(test_dict, keys, default)

    expect(get_val).to eq(checked_val)
    ret_vals(get_val, checked_val)
  end

  describe :containers do
    it "should get dictionary correctly" do
      vals = get_suit(:dict, {})

      expect_eq(vals, test_dict[:dict])
    end

    it "should get heirarchy value" do
      vals = hierarchy_suit([:dict, :k], nil)

      expect_eq(vals, test_dict[:dict][:k])
    end

    it "should get array correctly" do
      vals = get_suit(:array, [])

      expect_eq(vals, test_dict[:array])
    end
  end

  describe :POD_types do
    it "should retrieve symbols correctly" do
      vals = get_suit(:symbol, nil)

      expect_eq(vals, test_dict[:symbol])
    end

    it "should retrieve strings correctly" do
      vals = get_suit("string_key", nil)

      expect_eq(vals, test_dict["string_key"])
    end

    it "should retrieve integers correctly" do
      vals = get_suit(7, nil)

      expect_eq(vals, test_dict[7])
    end

    it "should retrieve default value for nil values" do
      vals = get_suit(:nil_key, 0)

      expect_eq(vals, 0)
    end

  end

  describe :errors do
    before(:each) do
      expect(test_class).to receive(:post_error).at_least(1).times
    end

    it "should return default for non-existant dictionary" do
      vals = get_suit(:fake_dir, {})

      expect_eq(vals, {})
    end

    it "should return default on non-existant hierarchy key" do
      vals = hierarchy_suit([:fake_dir, :k], nil)

      expect_eq(vals, nil)
    end

    it "should return default for non-existant top-level key" do
      vals = get_suit(:fake_key, 0)

      expect_eq(vals, 0)
    end

    it "should post error for invalid dictionary" do
      test_class.get_checked(nil, "key")
      test_class.get_hierarchy_checked(nil, ["key", "k2"])
    end
  end

end