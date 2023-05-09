cask "teclada" do
    version "0.0.42"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "96d858d9d20e082fbd7ae947c68526f635f830152fc3d30f39e542f603401196"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "f4320bed97b5bbb7a093b49d761e3e56e8e9389bd10c6ba4523620c8c5cd8339"
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
  
