class File
  # http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_276
  SAFE_CHARS = /[^a-zA-Z0-9._\-]/

  def self.safe_name(name)
    name.gsub('&', 'and') # prittify & to and
        .gsub(/\s/, '-') # replace spaces with dashes
        .gsub(SAFE_CHARS, '-') # replace with portable characters
        .gsub(/\-+/, '-') # limit - character to once
  end
end
