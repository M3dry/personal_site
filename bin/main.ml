(* let html_to_string html = Fmt.str "%a" (Tyxml.Html.pp_elt ()) html *)

(* let default_header title_str =
  let open Tyxml.Html in
  head
    (title (txt title_str))
    [ link ~rel:[ `Stylesheet ] ~href:"static/home.css" ()
    ; link
        ~rel:[ `Stylesheet ]
        ~href:"https://mshaugh.github.io/nerdfont-webfonts/build/ubuntu-nerd-font.css"
        ()
    ; script ~a:[ a_src "/static/htmx.min.js" ] (txt "")
    ]
;; *)

(* let icon ?(path = "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/") name alt_name =
  let open Tyxml.Html in
  img ~src:(path ^ name ^ ".svg") ~alt:(alt_name ^ " icon") ()
;;

let icon_button icon =
  let open Tyxml.Html in
  button ~a:[ a_class [ "knowledge-button" ] ] [ icon ]
;; *)

(* let knowledge name path =
  let open Tyxml.Html in
  div
    [ h2 ~a:[ a_class [ "knowledge-header" ] ] [ txt name ]
    ; div ~a:[ Hx.get @@ "/util/knowledge/" ^ path; Hx.trigger "load" ] []
    ]
;; *)

let () =
  Dream.run ~port:8000 ~interface:"0.0.0.0"
  @@ Dream.logger
  @@ Dream.router
       [ Dream.get "/static/**" @@ Dream.static "./static/"
       ; Dream.get "/" (fun _ -> Dream.html @@ Personal_site.template_to_html "index" [])
         (* let open Tyxml.Html in
           html
             (default_header "M3dry")
             (body
                [ div ~a:[ Hx.get "/util/navbar"; Hx.trigger "load" ] []
                ; div
                    ~a:[ a_id "knowledge" ]
                    [ h1 [ txt "Knowledge" ]
                    ; div ~a:[ Hx.get "/util/knowledge"; Hx.trigger "load" ] []
                    ]
                ])) *)
         (* ; Dream.get "/index" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "index"
           @@
           let open Jingoo in
           [ "name", Jg_types.Tstr "M3dry" ]) *)
       ; Dream.get "/util/navbar" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/navbar"
           @@
           let open Jingoo in
           [ ( "links"
             , Jg_types.Tlist
                 [ Jg_types.Tobj
                     [ "path", Jg_types.Tstr "https://github.com/m3dry"
                     ; "title", Jg_types.Tstr "Github - M3dry"
                     ; "name", Jg_types.Tstr "Github"
                     ]
                 ; Jg_types.Tobj
                     [ "path", Jg_types.Tstr "https://youtube.com/@m3dry"
                     ; "title", Jg_types.Tstr "Youtube - M3dry"
                     ; "name", Jg_types.Tstr "Youtube"
                     ]
                 ; Jg_types.Tobj
                     [ "path", Jg_types.Tstr "/blog"
                     ; "title", Jg_types.Tstr "Blog"
                     ; "name", Jg_types.Tstr "Blog"
                     ]
                 ] )
           ])
         (* @@ html_to_string
           @@
           let open Tyxml.Html in
           div
             ~a:[ a_class [ "nav-links" ] ]
             [ a
                 ~a:[ a_href "https://github.com/m3dry"; a_title "M3dry" ]
                 [ txt "Github" ]
             ; a
                 ~a:[ a_href "https://youtube.com/@m3dry"; a_title "M3dry" ]
                 [ txt "Youtube" ]
             ; a ~a:[ a_href "/blog"; a_title "Blog" ] [ txt "Blog" ]
             ]) *)
       ; Dream.get "/util/knowledge" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/knowledge"
           @@
           let open Jingoo in
           [ ( "knowledges"
             , Jg_types.Tlist
                 [ Jg_types.Tobj
                     [ "name", Jg_types.Tstr "Programming languages"
                     ; "path", Jg_types.Tstr "langs"
                     ]
                 ; Jg_types.Tobj
                     [ "name", Jg_types.Tstr "Tools"; "path", Jg_types.Tstr "tools" ]
                 ] )
           ])
         (* @@ html_to_string
           @@
           let open Tyxml.Html in
           div
             ~a:[ a_id "knowledge" ]
             [ knowledge "Programming languages" "langs"; knowledge "Tools" "tools" ]) *)
       ; Dream.get "/util/knowledge/langs" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/knowledgeBuilder"
           @@
           let open Jingoo.Jg_types in
           [ ( "icons"
             , Tlist
                 [ Tobj [ "name", Tstr "rust/rust-plain"; "alt_name", Tstr "Rust" ]
                 ; Tobj [ "name", Tstr "ocaml/ocaml-original-wordmark"; "alt_name", Tstr "Ocaml" ]
                 ] )
           ])
         (* @@ html_to_string
           @@
           let open Tyxml.Html in
           div
             ~a:[ a_class [ "knowledge-container" ] ]
             [ icon_button @@ icon "rust/rust-plain" "Rust"
             ; icon_button @@ icon "ocaml/ocaml-original-wordmark" "Ocaml"
             ]) *)
       ; Dream.get "/util/knowledge/tools" (fun _ ->
           Dream.html
           @@ Personal_site.template_to_html "util/knowledgeBuilder"
           @@
           let open Jingoo.Jg_types in
           [ ( "icons"
             , Tlist
                 [ Tobj [ "name", Tstr "git/git-original"; "alt_name", Tstr "Git" ]
                 ; Tobj [ "path", Tstr "./static/"; "name", Tstr "neovim"; "alt_name", Tstr "Neovim" ]
                 ] )
           ])
           (* @@ html_to_string
           @@
           let open Tyxml.Html in
           div
             ~a:[ a_class [ "knowledge-container" ] ]
             [ icon_button @@ icon "git/git-original" "Git"
             ; icon_button @@ icon ~path:"/static/" "neovim" "Neovim"
             ]) *)
       ]
;;
