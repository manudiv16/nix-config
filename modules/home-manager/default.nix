{
  pkgs,
  ...
}: {
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    silver-searcher
    neovim-remote
    ripgrep
    fd
    curl
    less
    nil
    python312Packages.cfn-lint
    tenv
    colima
    docker
    utm
    yazi
    awscli2
    direnv
    devbox
    k9s
    victor-mono
    fira-code
    fira-code-symbols
    docker-compose
    gh
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.eza.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --color=auto -F";
      nixswitch = "darwin-rebuild switch --flake ~/.config/nix-darwin/.#";
      nixup = "pushd ~/.config/nix-darwin; nix flake update; nixswitch; popd";
      assume = "source /opt/homebrew/bin/assume";
    };
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidgetCommand = "fd --exclude .git --type f"; # for when ctrl-t is pressed
    changeDirWidgetCommand = "fd --type d --hidden --follow --max-depth 3 --exclude .git";
  };
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    mutableExtensionsDir =
      true; # to allow vscode to install extensions not available via nix

    extensions =
      (with pkgs.vscode-extensions; [
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
      ])
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "opentofu";
          publisher = "gamunu";
          version = "2.1.14";
          sha256 = "sha256-OizdHTSGuwBRuD/qPXjmna6kZWfRp9EimhcFk3ICN9I=";
        }
      ];
    userSettings = {
      # Much of the following adapted from https://github.com/LunarVim/LunarVim/blob/4625145d0278d4a039e55c433af9916d93e7846a/utils/vscode_config/settings.json
      "editor.tabSize" = 2;
      "editor.fontLigatures" = true;
      "editor.guides.indentation" = false;
      "editor.insertSpaces" = true;
      "editor.fontFamily" = "'MesloLGL Nerd Font'";
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
      "nix.enableLanguageServer" = true;
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
        "[](color_orange)"
        "$os"
        "$username"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_blue bg:color_bg3)"
        "$docker_context"
        "$conda"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];

      palette = "gruvbox_dark";

      palettes = {
        gruvbox_dark = {
          color_fg0 = "#fbf1c7";
          color_bg1 = "#3c3836";
          color_bg3 = "#665c54";
          color_blue = "#458588";
          color_aqua = "#689d6a";
          color_green = "#98971a";
          color_orange = "#d65d0e";
          color_purple = "#b16286";
          color_red = "#cc241d";
          color_yellow = "#d79921";
        };
      };

      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";

        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          EndeavourOS = "";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };

      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = "󰝚 ";
          Pictures = " ";
          Developer = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:color_aqua}";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };

      git_status = {
        style = "bg:color_aqua}";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_blue}";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      docker_context = {
        symbol = "";
        style = "bg:color_bg3}";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      conda = {
        style = "bg:color_bg3}";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1}";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green})";
        error_symbol = "[](bold fg:color_red})";
        vimcmd_symbol = "[](bold fg:color_green})";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple})";
        vimcmd_replace_symbol = "[](bold fg:color_purple})";
        vimcmd_visual_symbol = "[](bold fg:color_yellow})";
      };
    };
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
    ignores = [
      "*.DS_Store"
      "*.swp"
      "devbox.json"
      "devbox.lock"
    ];
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
      default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      vim.g.lsp_elixir_bin = "${pkgs.elixir_ls}/bin/elixir-ls"
      vim.g.lsp_tsserver_bin = "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server"
      vim.g.lsp_tsserver_ts_path = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib"

      ${builtins.readFile ../../configs/nvim/defaults.lua}
      ${builtins.readFile ../../configs/nvim/base.lua}
      ${builtins.readFile ../../configs/nvim/theme.lua}
      ${builtins.readFile ../../configs/nvim/term.lua}
      ${builtins.readFile ../../configs/nvim/git.lua}
      ${builtins.readFile ../../configs/nvim/treesitter.lua}
      ${builtins.readFile ../../configs/nvim/telescope.lua}
      ${builtins.readFile ../../configs/nvim/lsp.lua}
      ${builtins.readFile ../../configs/nvim/cmp.lua}
    '';

    plugins = with pkgs;
      with pkgs.vimPlugins;
      let
        virt-column-nvim = vimUtils.buildVimPlugin {
          name = "virt-column-nvim";
          src = fetchFromGitHub {
            owner = "lukas-reineke";
            repo = "virt-column.nvim";
            rev = "b62b4ef0774d19452d4ed18e473e824c7a756f2f";
            hash = "sha256-7ljjJ7UwN2U1xPCtsYbrKdnz6SGQGbM/HrxPTxNKlwo=";
          };
        };
      in
      [
        # Appearance

        catppuccin-nvim
        indent-blankline-nvim
        nvim-web-devicons
        virt-column-nvim

        # Git

        gitsigns-nvim
        vim-fugitive
        vim-rhubarb

        # Programming

        cmp-nvim-lsp
        lsp-format-nvim
        lspsaga-nvim
        nvim-lspconfig
        nvim-treesitter
        nvim-treesitter-refactor
        nvim-treesitter-textobjects # TODO: Review and update config
        trouble-nvim

        # Misc

        barbar-nvim
        cmp-buffer
        emmet-vim
        lualine-nvim
        nerdcommenter # TODO: Review tcomment_vim
        nvim-cmp
        telescope-nvim
        telescope-symbols-nvim
        vim-easymotion
        vim-startify
        vim-vinegar
        vim-vsnip
        vim-vsnip
        vim-vsnip-integ

        # Dependencies

        plenary-nvim
        popup-nvim
        YankRing-vim # TODO: Review
        undotree # TODO: Review

        #     # TODO: Review neoformat
        #     # TODO: Review vim-table-mode
        #     # TODO: Review vim-which-key (has catppuccino integration)
        #     # TODO: Review - seneak.vim (has catppuccino integration)
        #     # TODO: Review fern / nvimtree / luatree  (have catppuccino integration)
      ];

  };
  home.file.".inputrc".source = ./dotfiles/inputrc;
}
