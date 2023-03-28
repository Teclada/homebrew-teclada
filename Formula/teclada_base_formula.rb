class TecladaBaseFormula < Formula
  desc "An empty formula."
  homepage "https://teclada.com/"
  url "https://github.com/Teclada/homebrew-teclada/archive/26513edf8dfc32e6541e2f74680b3e9fffdfc735.zip"
  version "1.0.0"
  sha256 "9464078c6cfc9379430c81e5185922f64350f47f7771204702d7016dfcc4467e"  
  license ""

  def install
    system "touch", "#{prefix}/empty_placeholder"    
  end
end
