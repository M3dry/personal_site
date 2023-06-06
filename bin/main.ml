let link name path =
  let open Jingoo.Jg_types in
  Tobj [ "name", Tstr name; "path", Tstr path ]
;;

let knowledge name cols icons =
  let open Jingoo.Jg_types in
  Tobj [ "name", Tstr name; "icons", Tlist icons; "cols", Tint cols ]
;;

type icon_behaviour =
  | Click of
      { link : string
      ; path : string
      ; name : string
      }
  | Link of string

let click link path name = Click { name; link; path }

let icon ?path name alt_name behaviour =
  let open Jingoo.Jg_types in
  let list =
    [ "name", Tstr name
    ; "alt_name", Tstr alt_name
    ; (match behaviour with
       | Click { name; link; path } ->
         ( "click"
         , Tstr
             (Personal_site.template_to_html
                "util/skills"
                [ "name", Tstr name
                ; "link", Tstr link
                ; "path", Tstr ("./templates/info/" ^ path ^ ".jingoo")
                ]) )
       | Link link -> "link", Tstr link)
    ]
  in
  Tobj
    (match path with
     | Some path -> ("path", Tstr path) :: list
     | None -> list)
;;

let () =
  Dream.run ~interface:"0.0.0.0"
  @@ Dream.logger
  @@ Dream.router
       [ Dream.get "/static/**" @@ Dream.static "./static/"
       ; Dream.get "/" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html
                "index"
                [ ( "links"
                  , Tlist
                      [ link "Github" "https://github.com"
                      ; link "Youtube" "https://youtube.com/@m3dry"
                      ; link "Blog" "/blog"
                      ] )
                ; ( "knowledges"
                  , Tlist
                      [ knowledge
                          "Programming languages"
                          6
                          [ icon "rust/rust-plain" "Rust"
                            @@ click "https://rust-lang.org" "langs/rust" "Rust"
                          ; icon "ocaml/ocaml-plain-wordmark" "OCaml"
                            @@ click "https://ocaml.org" "langs/ocaml" "OCaml"
                          ; Link "https://haskell.org"
                            |> icon "haskell/haskell-original" "Haskell"
                          ; Link "https://go.dev" |> icon ~path:"./static/" "go" "Go"
                          ; Link "https://lua.org" |> icon ~path:"./static/" "lua" "Lua"
                          ; Link "https://gcc.gnu.org" |> icon "c/c-line" "C"
                          ; Link "https://ziglang.org" |> icon "zig/zig-original" "Zig"
                          ; Link "https://javascript.com"
                            |> icon ~path:"./static/" "javascript" "Javascript"
                          ; Link "https://typescriptlang.org/"
                            |> icon ~path:"./static/" "typescript" "Typescript"
                          ; Link "https://gnu.org/software/bash/"
                            |> icon "/bash/bash-plain" "Bash"
                          ]
                      ; knowledge
                          "Tools"
                          3
                          [ Link "https://git-scm.com/"
                            |> icon ~path:"./static/" "git" "Git"
                          ; icon ~path:"./static/" "neovim" "Neovim"
                            @@ click "https://neovim.io" "tools/neovim" "Neovim"
                          ; Link "https://emacs.org"
                            |> icon ~path:"./static/" "emacs" "Emacs"
                          ; Link "https://linux.org"
                            |> icon "linux/linux-original" "Linux"
                          ; icon "nixos/nixos-original" "NixOS"
                            @@ click "https://nixos.org" "tools/nixos" "NixOS"
                          ; Link "https://docker.com"
                            |> icon "docker/docker-original-wordmark" "Docker"
                          ]
                      ; knowledge
                          "Frameworks"
                          4
                          [ Link "https://tailwindcss.com"
                            |> icon "tailwindcss/tailwindcss-plain" "Tailwind"
                          ; Link "https://svelte.dev"
                            |> icon "svelte/svelte-plain" "Svelte"
                          ]
                      ] )
                ])
       ]
;;
