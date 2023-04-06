cask "teclada" do
    version "0.0.35"

    if Hardware::CPU.arm?  
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "5524d7e15a960244eba0c837734899fe9b2a3ca7f1fc65cdf1dc8f5c68f3f034"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "bcf373c99d373914f9e160fcefa34176f668a732d1a872b258b021c98e7acc2b"
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
  
