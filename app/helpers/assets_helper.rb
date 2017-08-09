require Rails.root + 'lib/hesburgh_assets'

module AssetsHelper

  NUMBER_WORDS = {
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve"
  }

##
  def active_branch_path
    if active_branch_code == 'main'
      ''
    else
      "/#{active_branch_code.gsub('_library','')}"
    end
  end

  def active_branch_code
    if params[:active_branch_code].blank?
      'main'
    else
      params[:active_branch_code]
    end
  end

  def branch_site?
    active_branch_code != 'main'
  end

  def link_sub(contents)
    contents.gsub(/(href|src)="\//,"\\1=\"http://library.nd.edu/")
  end
  def rarebooks_link_sub(contents)
    contents.gsub(/(href|src)="\//,"\\1=\"http://rarebooks.library.nd.edu/")
  end

  def number_to_word(number)
    word = NUMBER_WORDS[number]
    if word.nil?
      raise "Invalid number"
    else
      word
    end
  end

  # Blocks rendered through development_only() will only display when Rails is running in the development environment
  def development_only(&block)
    if Rails.env == 'development'
      content_tag(:div,
        content_tag(:h4, "Development Only") + capture(&block),
        style: "border: dashed 1px #000;padding: 5px;"
      )
    end
  end

  def success
    flash[:success]
  end

  def error
    flash[:error]
  end

  def display_notices
    content = raw("")
    if notice
      content += content_tag(:div, notice, class: "alert alert-info")
    end
    if alert
      content += content_tag(:div, alert, class: "alert")
    end
    if success
      content += content_tag(:div, success, class: "alert alert-success")
    end
    if error
      content += content_tag(:div, error, class: "alert alert-error")
    end
    content_tag(:div, content, id: "notices")
  end

  def white_box(&block)
    content = capture(&block)
    content_tag(:div, content, :class => "box")
  end

  def yellow_box(&block)
    content = capture(&block)
    content_tag(:div, content, :class => "box yellow")
  end

  def content_title(title)
    content_for(:content_title, content_tag(:h1, title))
  end

  def content_title_links(*links)
    content_for(:content_title_links, raw(links.join(" ")))
  end

  def preheader_content
  end

  def breadcrumb(*crumbs)
    crumbs.unshift(application_crumb)
    crumbs.unshift(root_crumb)
    crumbs.delete(nil)
    content_for(:breadcrumb, content_tag(:p, raw(crumbs.join(" &gt; "))))
  end

  def root_crumb
    link_to("Hesburgh Libraries", library_url())
  end

  def application_crumb
    link_to(application_name, root_path)
  end

  def application_name
    Rails.application.class.parent_name.to_s.titleize
  end

  def body_class
    if @body_class.present?
      raw "class=\"#{@body_class.html_safe}\""
    end
  end

  def set_body_class(new_class)
    @body_class = new_class
  end

  def library_url(path = nil)
    if path && !(path =~ /^\//)
      path = "/#{path}"
    end
    "http://#{HesburghAssets.library_host}#{path}"
  end

  def hesburgh_asset_path(directory, file, options = {})
    version = options.delete(:version) || "1.0"
    path = "hesburgh_assets/#{directory}/#{version}/#{file}"
    if asset_host = HesburghAssets.assets_host
      path = "//#{asset_host}/assets/#{path}"
    end
    path
  end

  def hesburgh_stylesheet_link_tag(directory, file, options = {})
    path = hesburgh_asset_path(directory, file, options)
    stylesheet_link_tag(path, options)
  end

  def hesburgh_javascript_include_tag(directory, file, options = {})
    path = hesburgh_asset_path(directory, file, options)
    javascript_include_tag(path, options)
  end


  # Includes the relevant library SSI file from http://library.nd.edu/ssi/<filename>.shtml
  def include_ssi(filepath)
    if Rails.env == 'test'
      "SSI INCLUDE !!!"
    else
      render :partial => "/layouts/include_ssi", :locals => {:filepath => filepath}
    end
  end


  def breadcrumb(*crumbs)
    crumbs.unshift(link_to("Hesburgh Libraries", "https://library.nd.edu"))
    content_for(:breadcrumb, raw(crumbs.join(" &gt; ")))
  end


  def display_notices
    content = raw("")
    if notice.present?
      content += content_tag(:div, raw(notice), class: "alert alert-info")
    end
    if alert.present?
      content += content_tag(:div, raw(alert), class: "alert")
    end
    if success.present?
      content += content_tag(:div, raw(success), class: "alert alert-success")
    end
    if flash[:error].present?
      content += content_tag(:div, raw(flash[:error]), class: "alert alert-error")
    end
    content_tag(:div, content, id: "notices")
  end


  def help_popover(title, content, klass = "popover_help")
    link_to(image_tag("help.png"), "#", "data-original-title" => title, "data-content" => content, :class => klass)
  end

end
