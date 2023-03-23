cask "teclada" do
    version "0.0.30"

    if Hardware::CPU.arm?
        #sha256 "9b067794162b659e4504137c3ea4ec8cbaca46e24d6bc00349c82d9fec33c0b8"
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        #sha256 "654bf5a3648c733d721af40cb6975e62fcefb37c5f96efed77c96ed52ee5872c"
    end
        
    name "Teclada"
    desc "The modern terminal for the modern developer."
    homepage "https://www.teclada.com/"

    depends_on formula: "bash"

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
  
