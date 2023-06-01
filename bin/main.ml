let () =
  (* if Array.length Sys.argv != 0 *)
  (* then Printf.printf "\n%s@.\n" @@ Personal_site.template_to_html "index"  *)
  (* else *)
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
                      [ Tobj
                          [ "path", Tstr "https://github.com/m3dry"
                          ; "title", Tstr "Github - M3dry"
                          ; "name", Tstr "Github"
                          ]
                      ; Tobj
                          [ "path", Tstr "https://youtube.com/@m3dry"
                          ; "title", Tstr "Youtube - M3dry"
                          ; "name", Tstr "Youtube"
                          ]
                      ; Tobj
                          [ "path", Tstr "/blog"
                          ; "title", Tstr "Blog"
                          ; "name", Tstr "Blog"
                          ]
                      ] )
                ; ( "knowledges"
                  , Tlist
                      [ Tobj
                          [ "name", Tstr "Programming languages"
                          ; ( "icons"
                            , Tlist
                                [ Tobj
                                    [ "name", Tstr "rust/rust-plain"
                                    ; "alt_name", Tstr "Rust"
                                    ; "click", Tstr "/info/langs/rust"
                                    ]
                                ; Tobj
                                    [ "name", Tstr "ocaml/ocaml-plain-wordmark"
                                    ; "alt_name", Tstr "Ocaml"
                                    ; "click", Tstr "/info/langs/ocaml"
                                    ]
                                ] )
                          ]
                      ; Tobj
                          [ "name", Tstr "Tools"
                          ; ( "icons"
                            , Tlist
                                [ Tobj
                                    [ "name", Tstr "git/git-original"
                                    ; "alt_name", Tstr "Git"
                                    ; "link", Tstr "https://git-scm.com/"
                                    ]
                                ; Tobj
                                    [ "path", Tstr "./static/"
                                    ; "name", Tstr "neovim"
                                    ; "alt_name", Tstr "Neovim"
                                    ; "click", Tstr "/info/tools/neovim"
                                    ]
                                ; Tobj
                                    [ "name", Tstr "docker/docker-original-wordmark"
                                    ; "alt_name", Tstr "Docker"
                                    ; "link", Tstr "https://www.docker.com/"
                                    ]
                                ] )
                          ]
                      ] )
                ])
       ; (let path = "info/langs/ocaml" in
          Dream.get path (fun _ ->
            Dream.html @@ Personal_site.template_to_html path []))
       ; (let path = "info/langs/rust" in
          Dream.get path (fun _ ->
            Dream.html @@ Personal_site.template_to_html path []))
       ; (let path = "info/tools/neovim" in
          Dream.get path (fun _ ->
            Dream.html @@ Personal_site.template_to_html path []))
       ]
;;
