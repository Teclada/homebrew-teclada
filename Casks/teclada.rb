cask "teclada" do
    version "0.0.31"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "aceb9d75d5ead6e2734eb353a0f1ae34b1f319d781bc7476bd1b429ffa3a5a8d"      
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "8a28a941267cf8a1eb542b28ee40986722c9173e56b93c0469b24937d073095f"
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
  
