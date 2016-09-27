module DictionaryHelper
  include ErrorHelper

  def get(dict, key, defaultVal = nil)
    if (dict && dict[key]) then dict[key] else defaultVal end
  end

  def get_checked(dict, key, defaultVal = nil, context = "")
    check_dictionary_key(dict, key, context)
    get(dict, key, defaultVal)
  end

  def get_hierarchy(dict, keys, defaultVal = nil)
    if not dict then
      return defaultVal
    end

    curDict = dict
    keys.each do |key|
      if !curDict[key] then
        return defaultVal
      end
      curDict = curDict[key]
    end
    curDict
  end

  def get_hierarchy_checked(dict, keys, defaultVal = nil, context = "")
    check_dictionary_hierarchy(dict, keys, context)
    get_hierarchy(dict, keys, defaultVal)
  end

end