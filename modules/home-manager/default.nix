{
  pkgs,
  pwnvim,
  ...
}: {
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
    python312Packages.cfn-lint
    tenv
    colima
    docker
    utm
    pwnvim.packages."aarch64-darwin".default
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.eza.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.shellAliases = {
    ls = "ls --color=auto -F";
    nixswitch = "darwin-rebuild switch --flake ~/.config/nix-darwin/.#";
    nixup = "pushd ~/.config/nix-darwin; nix flake update; nixswitch; popd";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "\fd --type f --hidden --exclude .git";
    fileWidgetCommand = "\fd --exclude .git --type f"; # for when ctrl-t is pressed
    changeDirWidgetCommand = "\fd --type d --hidden --follow --max-depth 3 --exclude .git";
  };
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    mutableExtensionsDir = true; # to allow vscode to install extensions not available via nix

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      scala-lang.scala
      svelte.svelte-vscode
      redhat.vscode-yaml
      jnoortheen.nix-ide
      tamasfe.even-better-toml
      ms-python.python
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
      esbenp.prettier-vscode
      timonwong.shellcheck
      rust-lang.rust-analyzer
      graphql.vscode-graphql
      dbaeumer.vscode-eslint
      codezombiech.gitignore
      bierner.markdown-emoji
      bradlc.vscode-tailwindcss
      naumovs.color-highlight
      mikestead.dotenv
      mskelton.one-dark-theme
      brettm12345.nixfmt-vscode
      davidanson.vscode-markdownlint
      pkief.material-icon-theme
      dracula-theme.theme-dracula
      eamodio.gitlens # for git blame
      marp-team.marp-vscode # for markdown slides
      ms-vsliveshare.vsliveshare # live share coding with others
      github.vscode-github-actions
      mhutchie.git-graph
      github.copilot
      github.copilot-chat # for copilot chat
    ];
    userSettings = {
      # Much of the following adapted from https://github.com/LunarVim/LunarVim/blob/4625145d0278d4a039e55c433af9916d93e7846a/utils/vscode_config/settings.json
      "editor.tabSize" = 2;
      "editor.fontLigatures" = true;
      "editor.guides.indentation" = false;
      "editor.insertSpaces" = true;
      "editor.fontFamily" = "'Hasklug Nerd Font', 'JetBrainsMono Nerd Font', 'FiraCode Nerd Font','SF Mono', Menlo, Monaco, 'Courier New', monospace";
      "editor.fontSize" = 12;
      "editor.formatOnSave" = true;
      "editor.suggestSelection" = "first";
      "editor.scrollbar.horizontal" = "hidden";
      "editor.scrollbar.vertical" = "hidden";
      "editor.scrollBeyondLastLine" = false;
      "editor.cursorBlinking" = "solid";
      "editor.minimap.enabled" = false;
      "[nix]"."editor.tabSize" = 2;
      "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
      "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "extensions.ignoreRecommendations" = false;
      "files.insertFinalNewline" = true;
      "[scala]"."editor.tabSize" = 2;
      "[json]"."editor.tabSize" = 2;
      "files.trimTrailingWhitespace" = true;
      "gitlens.codeLens.enabled" = false;
      "gitlens.currentLine.enabled" = false;
      "gitlens.hovers.currentLine.over" = "line";
      "git.confirmSync" = false;
      "workbench.editor.showTabs" = "multiple";
      "workbench.colorTheme" = "One Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.accessibilitySupport" = "off";
      "oneDark.bold" = true;
      "window.zoomLevel" = 1;

      "svelte.enable-ts-plugin" = true;
      "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "javascript.referencesCodeLens.enabled" = true;
      "javascript.suggest.completeFunctionCalls" = true;
      "yaml.customTags" = [
        "!And"
        "!If"
        "!Not"
        "!Equals"
        "!Or"
        "!FindInMap sequence"
        "!Base64"
        "!Cidr"
        "!Ref"
        "!Sub"
        "!GetAtt"
        "!GetAZs"
        "!ImportValue"
        "!Select"
        "!Select sequence"
        "!Split"
        "!Join sequence"
      ];
      "yaml.format.enable" = true;
      "editor.tokenColorCustomizations" = {
        "textMateRules" = [
          {
            "name" = "One Dark bold";
            "scope" = [
              "entity.name.function"
              "entity.name.type.class"
              "entity.name.type.module"
              "entity.name.type.namespace"
              "keyword.other.important"
            ];
            "settings" = {"fontStyle" = "bold";};
          }
          {
            "name" = "One Dark italic";
            "scope" = [
              "comment"
              "entity.other.attribute-name"
              "keyword"
              "markup.underline.link"
              "storage.modifier"
              "storage.type"
              "string.url"
              "variable.language.super"
              "variable.language.this"
            ];
            "settings" = {"fontStyle" = "italic";};
          }
          {
            "name" = "One Dark italic reset";
            "scope" = [
              "keyword.operator"
              "keyword.other.type"
              "storage.modifier.import"
              "storage.modifier.package"
              "storage.type.built-in"
              "storage.type.function.arrow"
              "storage.type.generic"
              "storage.type.java"
              "storage.type.primitive"
            ];
            "settings" = {"fontStyle" = "";};
          }
          {
            "name" = "One Dark bold italic";
            "scope" = ["keyword.other.important"];
            "settings" = {"fontStyle" = "bold italic";};
          }
        ];
      };
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      format = pkgs.lib.concatStrings [
        "$os"
        "$shell"
        "$username"
        "$hostname"
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$git_branch"
        "$hg_branch"
        "$pijul_channel"
        "$sudo"
        "$jobs"
        "$line_break"
        "$battery"
        "$time"
        "$status"
        "$container"
        "$character"
      ];
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };
      scan_timeout = 30;
      add_newline = true;
      gcloud.disabled = true;
      aws.disabled = true;
      os.disabled = false;
      os.symbols.Macos = "";
      git_status.style = "blue";
      git_metrics.disabled = false;
      git_branch.style = "bright-black";
      git_branch.format = "[  ](bright-black)[$symbol$branch(:$remote_branch)]($style) ";
      time.disabled = true;
      directory = {
        format = "[    ](bright-black)[$path]($style)[$read_only]($read_only_style)";
        truncation_length = 4;
        truncation_symbol = "…/";
        style = "bold blue"; # cyan
        truncate_to_repo = false;
      };
      directory.substitutions = {
        "Library/Containers/co.noteplan.NotePlan3/Data/Library/Application Support/co.noteplan.NotePlan3" = "Notes";
      };
      package.disabled = true;
      package.format = "version [$version](bold green) ";
      nix_shell.symbol = " ";
      rust.symbol = " ";
      shell = {
        disabled = false;
        format = "[$indicator]($style)";
        style = "bright-black";
        bash_indicator = " bsh";
        nu_indicator = " nu";
        fish_indicator = " ";
        zsh_indicator = ""; # don't show when in my default shell type
        unknown_indicator = " ?";
        powershell_indicator = " _";
      };
      cmd_duration = {
        format = "[$duration]($style)   ";
        style = "bold yellow";
        min_time_to_notify = 5000;
      };
      jobs = {
        symbol = "";
        style = "bold red";
        number_threshold = 1;
        format = "[$symbol]($style)";
      };
    };
  };
  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "MesloLGS Nerd Font Mono";
    settings.font.size = 16;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Fran Martin";
    userEmail = "38869988+manudiv16@users.noreply.github.com";
    signing = {
        key = "EBC89F78291E88AC61092B5D745196D8F5B4152F";
        signByDefault = true;
      };
    aliases = {
      gone = ''
        ! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]" {print $1}' | xargs -r git branch -D'';
      tatus = "status";
      co = "checkout";
      br = "branch";
      st = "status -sb";
      wtf = "!git-wtf";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --topo-order --date=relative";
      gl = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --topo-order --date=relative";
      lp = "log -p";
      lr = "reflog";
      ls = "ls-files";
      dall = "diff";
      d = "diff --relative";
      dv = "difftool";
      df = "diff --relative --name-only";
      dvf = "difftool --relative --name-only";
      dfall = "diff --name-only";
      ds = "diff --relative --name-status";
      dvs = "difftool --relative --name-status";
      dsall = "diff --name-status";
      dvsall = "difftool --name-status";
      dr = "diff-index --cached --name-only --relative HEAD";
      di = "diff-index --cached --patch --relative HEAD";
      dfi = "diff-index --cached --name-only --relative HEAD";
      subpull = "submodule foreach git pull";
      subco = "submodule foreach git checkout master";
    };
    extraConfig =
      {
        github.user = "manudiv16";
        color.ui = true;
        pull.rebase = true;
        merge.conflictstyle = "diff3";
        init.defaultBranch = "main";
        http.sslVerify = true;
        commit.verbose = true;
        commit.gpgSign = true;
        tag.gpgSign = true;
        credential.helper =
          if pkgs.stdenvNoCC.isDarwin
          then "osxkeychain"
          else "cache --timeout=10000000";
        diff.algorithm = "patience";
        protocol.version = "2";
        core.commitGraph = true;
        gc.writeCommitGraph = true;
        push.autoSetupRemote = true;
      }
      // pkgs.lib.optionalAttrs pkgs.stdenv.isDarwin {
        core.fsmonitor = true;
        core.untrackedcache = true;
      };
    # Really nice looking diffs
    delta = {
      enable = false;
      options = {
        syntax-theme = "Monokai Extended";
        line-numbers = true;
        navigate = true;
        side-by-side = true;
      };
    };
    # intelligent diffs that are syntax parse tree aware per language
    difftastic = {
      enable = true;
      background = "dark";
    };
  };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        front_end = "WebGpu",
      }
    '';
  };
  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ../../configs/kitty.conf;
    theme = "Gruvbox Material Dark Hard";
  };
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
    settings = {
      default-key = "EBC89F78291E88AC61092B5D745196D8F5B4152F";
      no-emit-version = true;
      no-comments = true;
      keyid-format = "0xlong";
      with-fingerprint = true;
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      use-agent = true;
      keyserver = "hkps://keys.openpgp.org/";
      keyserver-options = "no-honor-keyserver-url include-revoked";
      personal-cipher-preferences = "AES256 AES192 AES CAST5";
      personal-digest-preferences = "SHA512 SHA384 SHA256 SHA224";
      cert-digest-algo = "SHA512";
      default-preference-list =
        "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    };
  };
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
