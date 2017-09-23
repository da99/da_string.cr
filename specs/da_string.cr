
require "spec"
require "../src/da_string"

describe ":clean" do

  it "returns nil if nb (non-breaking) spaces (160 codepoint)" do
    str = [160, 160,64, 116, 119, 101, 108, 108, 121, 109, 101, 160, 102, 105, 108, 109].map { |x|
      x.chr
    }.join
    # "**@twellyme*film"

    DA_STRING.clean(str).should eq(nil)
  end

  utf8_whitespace = "\u205f \u3000 \u0085 \u00a0 \u2007"
  it "replaces utf-8 whitespace with a space: #{utf8_whitespace}" do
    str = utf8_whitespace
    new_str = DA_STRING.clean(str) || "error"
    new_str.split.uniq.join
      .should eq("")
  end

  it "replaces the No-Break Space (U+00A0) with an empty space" do
    str = "a\u{A0}\u00A0A"
    DA_STRING.clean(str)
      .should eq("a  A")
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








