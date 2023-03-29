cask "teclada" do
    version "0.0.31"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "e74a2615afaa1070ea2f85df93ac331087a8f69b667011537e79aec0687c4506"      
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "380594dcd590fa4b25d1ebf05c8070e55197151ed314a8e1c592bc4e5a0f34e5"
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
  
