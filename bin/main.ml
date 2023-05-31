let () =
  Dream.run ~port:8000 ~interface:"0.0.0.0"
  @@ Dream.logger
  @@ Dream.router
       [ Dream.get "/static/**" @@ Dream.static "./static/"
       ; Dream.get "/" (fun _ -> Dream.html @@ Personal_site.template_to_html "index" [])
       ; Dream.get "/util/navbar" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/navbar"
           @@
           let open Jingoo.Jg_types in
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
                     [ "path", Tstr "/blog"; "title", Tstr "Blog"; "name", Tstr "Blog" ]
                 ] )
           ])
       ; Dream.get "/util/knowledge" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/knowledge"
           @@
           let open Jingoo.Jg_types in
           [ ( "knowledges"
             , Tlist
                 [ Tobj [ "name", Tstr "Programming languages"; "path", Tstr "langs" ]
                 ; Tobj [ "name", Tstr "Tools"; "path", Tstr "tools" ]
                 ] )
           ])
       ; Dream.get "/util/knowledge/langs" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/knowledgeBuilder"
           @@
           let open Jingoo.Jg_types in
           [ ( "icons"
             , Tlist
                 [ Tobj [ "name", Tstr "rust/rust-plain"; "alt_name", Tstr "Rust" ]
                 ; Tobj
                     [ "name", Tstr "ocaml/ocaml-plain-wordmark"
                     ; "alt_name", Tstr "Ocaml"
                     ]
                 ] )
           ])
       ; Dream.get "/util/knowledge/tools" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/knowledgeBuilder"
           @@
           let open Jingoo.Jg_types in
           [ ( "icons"
             , Tlist
                 [ Tobj [ "name", Tstr "git/git-original"; "alt_name", Tstr "Git" ]
                 ; Tobj
                     [ "path", Tstr "./static/"
                     ; "name", Tstr "neovim"
                     ; "alt_name", Tstr "Neovim"
                     ]
                 ; Tobj
                     [ "name", Tstr "docker/docker-original-wordmark"
                     ; "alt_name", Tstr "Docker"
                     ]
                 ] )
           ])
       ]
;;
