cask "teclada" do
    version "0.0.41"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "7d04151235fb24d3d741e45ff22bbcabac12843479f5a25f4e61134d54accb70"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "eb6efc615861ba2e62429cf99788b91f3a72be48de5b0d98223a8b95994e771d"
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
  
