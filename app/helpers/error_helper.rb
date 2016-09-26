module ErrorHelper

  def check_dictionary_key(dict, key, context = "")
    if not dict then
      post_error("Dictionary #{context} is invalid")
      return false
    end

    if not dict[key] then
      post_key_error(key, context)
      return false
    end

    return true
  end

  def check_dictionary_flat(dict, keys, context = "")
    keys.each do |key|
      check_dictionary_key(dict, key, context)
    end
  end

  def check_dictionary_hierarchy(dict, keys_top_down, context = "")
    curDict = dict
    keys_top_down.each do |key|
      if not check_dictionary_key(curDict, key, context) then
        return false
      end

      curDict = curDict[key]
    end
    true
  end

  def post_error(errMsg)
    puts errMsg
  end

  def post_key_error(key, context)
    post_error "Could not find #{key} in dictionary #{context}"
  end

end