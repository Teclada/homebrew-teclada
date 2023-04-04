cask "teclada" do
    version "0.0.33"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "d8ffdf600250b64799c5835262a12dcb16f663b0e1a965746c2135c854baf703"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "61e7ff5dd4360285411cdba58f664160478720b79d649a38d3ce092270a0430e"
    end
        
    name "Teclada"
    desc "The modern terminal for the modern developer."
    homepage "https://www.teclada.com/"

    depends_on formula: "bash"
    depends_on formula: "teclada_base_formula"

    binary "usr/local/bin/teclada"
    binary "usr/local/bin/teclada_setup"

    # Record that this was a homebrew installation
    installer script: {
        executable: "/bin/bash",
        args:       ["-c", "printf 'brew' > '#{staged_path}/usr/local/bin/teclada_installation_method'"],
    }
    installer script: {
        executable: "/bin/bash",
        args:       ["-c", "printf '#{HOMEBREW_PREFIX}/' > '#{staged_path}/usr/local/bin/teclada.runfiles/host/install/homebrew_prefix'"],
    }

    # Make Apple super mad :)
    installer script: {
        executable: "/bin/bash",
        args:       ["-c", "xattr -r -d com.apple.metadata:kMDItemWhereFroms '#{staged_path}'"],
    }
    installer script: {
        executable: "/bin/bash",
        args:       ["-c", "xattr -r -d com.apple.quarantine '#{staged_path}'"],
    }

  end
  
