cask "teclada" do
    version "0.0.39"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "9419a57dafa0c04c734b6b8963d3514428e4f1e440389c4b554081ac9c7ede8e"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "a427a4dde90a10d37b5eb0df6157a2f2922d6fb62d51e0e6a66649f038a37f4e"
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
        args:       ["-c", "(printf 'brew' > '#{staged_path}/usr/local/bin/teclada_installation_method') || true"],
    }
    installer script: {
        executable: "/bin/bash",
        args:       ["-c", "(printf '#{HOMEBREW_PREFIX}/' > '#{staged_path}/usr/local/bin/teclada.runfiles/host/install/homebrew_prefix') || true"],
    }

    # Make Apple super mad :)
    installer script: {
        executable: "/bin/bash",
        args:       ["-c", "(xattr -r -d com.apple.metadata:kMDItemWhereFroms '#{staged_path}') || true"],
    }
    installer script: {
        executable: "/bin/bash",
        args:       ["-c", "(xattr -r -d com.apple.quarantine '#{staged_path}') || true"],
    }

  end
  
