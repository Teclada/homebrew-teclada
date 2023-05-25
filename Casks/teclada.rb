cask "teclada" do
    version "0.0.44"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "c2c7f9447af3fb6100f38b2d074c81ba97cbd87f70ade0e55a0d13a97e30d6af"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "4b1112b37e66b7a5e24619e849376bad283067298c8fa1daa885db731521bc1e"
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
  
