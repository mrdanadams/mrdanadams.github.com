module CustomFilters
  # Hack to remove un-parsed liquid templates from excerpts.
  def strip_liquid(source)
    # Liquid::Template.parse(source).render(@context)
    source.
      gsub(/\[([^\]]+)\]\([^\)]+\)/, '\1'). # links
      gsub(/\!?\[([^\]]+)\]\([^\)]+\)/, '') # images
  end
end

Liquid::Template.register_filter CustomFilters