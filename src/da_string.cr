
module DA_STRING

  extend self

  SPACE_CODEPOINT    = " ".codepoints.first
  TILDA_CODEPOINT    = "~".codepoints.first
  NEW_LINE_CODEPOINT = "\n".codepoints.first
  TAB_CODEPOINT      = "\t".codepoints.first

  DOUBLE_SPACE = "  "
  NEW_LINE     = "\n"
  SPACE        = " "

  ASCII_TABLE = Array(String | Nil).new("~".codepoints.first + 1, nil)

  (SPACE_CODEPOINT..TILDA_CODEPOINT).each_with_index do |x, i|
    ASCII_TABLE[x] = [x.chr].join
  end

  ASCII_TABLE[NEW_LINE_CODEPOINT] = "\n"

  def clean(s : String, new_str : IO::Memory)
    return nil unless s.valid_encoding?

    s.codepoints.each { |x|
      new_str << case x
      when 9 # tab
        DOUBLE_SPACE

      when 10 # 10 = new line
        NEW_LINE

      when 0..31 # 0-31  - \x00-\x1F
        SPACE

      when 127 # 127   - DEL, \x7F
        SPACE

      when 65533 # 65533 - REPLACEMENT CHAR
        "?"

      else
        (ASCII_TABLE[x]? && ASCII_TABLE[x]) || x.chr

      end
    }

    new_str
  end # === def clean

  def clean(s : String)
    new_str = clean(s, IO::Memory.new)
    case new_str
    when IO::Memory
      new_str.to_s
    else
      new_str
    end
  end # === def clean

end # === module DA_STRING
