cask "teclada" do
    version "0.0.53"

    if Hardware::CPU.arm?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_arm64.tar.gz"
        sha256 "76a9efe922800211babbac2003e2d45245e7059850b5430333cc606e52fc3d4e"
    elsif Hardware::CPU.intel?
        url "https://github.com/Teclada/teclada/releases/download/#{version}/teclada_mac_x86_64.tar.gz"
        sha256 "2b32973bdaa157e1ee9cae821a0be57e73ee535b0d04775f902e9d29c7a10d31"
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
