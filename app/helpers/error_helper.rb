module ErrorHelper

  def check_dictionary_key(dict, key, context = "", notify=false)
    if not dict then
      post_error("Dictionary #{context} is invalid", true, "dictionary")
      return false
    end

    if not dict[key] then
      post_key_error(key, context, notify)
      return false
    end

    return true
  end

  def check_dictionary_flat(dict, keys, context = "", notify=false)
    keys.each do |key|
      if not check_dictionary_key(dict, key, context, notify) then
        return false
      end
    end
    return true
  end

  def check_dictionary_hierarchy(dict, keys_top_down, context = "", notify=false)
    curDict = dict
    keys_top_down.each do |key|
      if not check_dictionary_key(curDict, key, context, notify) then
        return false
      end

      curDict = curDict[key]
    end
    true
  end

  def post_error(errMsg, notify=false, catagory="")
    puts errMsg
    if notify then
      Airbrake.notify(
        error_message: errMsg,
        error_class:   "Custom::#{catagory}"
      )
    end
  end

  def post_key_error(key, context, notify=false)
    post_error("Could not find #{key} in dictionary #{context}", notify, "dictionary")
  end

end