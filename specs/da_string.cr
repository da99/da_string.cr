
require "spec"
require "../src/da_string"

UTF8_WHITESPACE = "\u205f \u3000 \u0085 \u00a0 \u2007"

describe ":clean" do

  # See why non-breaking spaces are necessary:
  # https://practicaltypography.com/nonbreaking-spaces.html
  it "should not remove non-breaking spaces (160 codepoint)" do
    str = "  @twellyme film"
    codepoints = [160, 160,64, 116, 119, 101, 108, 108, 121, 109, 101, 160, 102, 105, 108, 109]
    # "**@twellyme*film"

    (DA_STRING.clean(codepoints.map { |x| x.chr }.join) || "").codepoints
      .should eq(codepoints)
    DA_STRING.clean(codepoints.map { |x| x.chr }.join)
      .should eq(str)
  end

  it "does not replace utf-8 whitespace: #{UTF8_WHITESPACE}" do
    new_str = (DA_STRING.clean(UTF8_WHITESPACE) || "error")

    new_str.valid_encoding?
      .should eq(true)

    new_str
      .should eq(UTF8_WHITESPACE)
  end

  it "does not replaces the No-Break Space (U+00A0)" do
    str = "a\u{A0}\u00A0A"
    DA_STRING.clean(str)
      .should eq(str)
  end

  it "replaces \\r with space" do
    str = "r\r\rR"
    DA_STRING.clean(str)
      .should eq("r  R")
  end

  it "replaces each tab with 2 spaces" do
    s = ".\t \tTAB"
    DA_STRING.clean(s)
      .should eq(".     TAB")
  end

end # === describe :clean_utf8 ===








