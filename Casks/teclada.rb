cask "teclada" do
    version "0.0.30"

    if Hardware::CPU.arm?
        sha256 "ccd1325b145732ab73d00d11329631d74bd3b16aeb0ffdffbf15af318e033337"        
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "5b96cce4cc6e8c2795f333990fcba8f13de94db3ae8068550adf462999787075"
    end
        
    name "Teclada"
    desc "The modern terminal for the modern developer."
    homepage "https://www.teclada.com/"

    depends_on formula: "bash"
    depends_on formula: "teclada_base_formula"

    binary "usr/local/bin/teclada"
    binary "usr/local/bin/teclada_setup"

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
  
