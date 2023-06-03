let link name path =
  let open Jingoo.Jg_types in
  Tobj [ "name", Tstr name; "path", Tstr path ]
;;

let knowledge name icons =
  let open Jingoo.Jg_types in
  Tobj [ "name", Tstr name; "icons", Tlist icons ]
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
  Dream.run
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
                          [ icon "rust/rust-plain" "Rust"
                            @@ click "https://rust-lang.org" "langs/rust" "Rust"
                          ; icon "ocaml/ocaml-plain-wordmark" "OCaml"
                            @@ click "https://ocaml.org" "langs/ocaml" "OCaml"
                          ; Link "https://haskell.org"
                            |> icon "haskell/haskell-original" "Haskell"
                          ]
                      ; knowledge
                          "Tools"
                          [ Link "https://git-scm.com/" |> icon "git/git-original" "Git"
                          ; icon ~path:"./static/" "neovim" "Neovim"
                            @@ click "https://neovim.io" "tools/neovim" "Neovim"
                          ; Link "https://docker.com"
                            |> icon "docker/docker-original-wordmark" "Docker"
                          ; icon "nixos/nixos-original" "NixOS"
                            @@ click "https://nixos.org" "tools/nixos" "NixOS"
                          ]
                      ; knowledge
                          "Frameworks"
                          [ Link "https://tailwindcss.com"
                            |> icon "tailwindcss/tailwindcss-plain" "Tailwind"
                          ]
                      ] )
                ])
       ]
;;
