let html_to_string html = Fmt.str "%a" (Tyxml.Html.pp_elt ()) html

let default_header title_str =
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
;;

let icon ?(path = "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/") name alt_name =
  let open Tyxml.Html in
  img ~src:(path ^ name ^ ".svg") ~alt:(alt_name ^ " icon") ()
;;

let icon_button icon =
  let open Tyxml.Html in
  button ~a:[ a_class [ "knowledge-button" ] ] [ icon ]
;;

let knowledge name path =
  let open Tyxml.Html in
  div
    [ h2 ~a:[ a_class [ "knowledge-header" ] ] [ txt name ]
    ; div ~a:[ Hx.get @@ "/util/knowledge/" ^ path; Hx.trigger "load" ] []
    ]
;;

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router
       [ Dream.get "/static/**" @@ Dream.static "./static/"
       ; Dream.get "/" (fun _ ->
           Dream.html
           @@ html_to_string
           @@
           let open Tyxml.Html in
           html
             (default_header "M3dry")
             (body
                [ div ~a:[ Hx.get "/util/navbar"; Hx.trigger "load" ] []
                ; div
                    ~a:[ a_id "knowledge" ]
                    [ h1 [ txt "Knowledge" ]
                    ; div ~a:[ Hx.get "/util/knowledge"; Hx.trigger "load" ] []
                    ]
                ]))
       ; Dream.get "/index" (fun _ ->
           Dream.html @@ Personal_site.template_to_html "index" @@ `O [ "name", `String "M3dry" ])
       ; Dream.get "/util/navbar" (fun _ ->
           Dream.html
           @@ html_to_string
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
             ])
       ; Dream.get "/util/knowledge" (fun _ ->
           Dream.html
           @@ html_to_string
           @@
           let open Tyxml.Html in
           div
             ~a:[ a_id "knowledge" ]
             [ knowledge "Programming languages" "langs"; knowledge "Tools" "tools" ])
       ; Dream.get "/util/knowledge/langs" (fun _ ->
           Dream.html
           @@ html_to_string
           @@
           let open Tyxml.Html in
           div
             ~a:[ a_class [ "knowledge-container" ] ]
             [ icon_button @@ icon "rust/rust-plain" "Rust"
             ; icon_button @@ icon "ocaml/ocaml-original-wordmark" "Ocaml"
             ])
       ; Dream.get "/util/knowledge/tools" (fun _ ->
           Dream.html
           @@ html_to_string
           @@
           let open Tyxml.Html in
           div
             ~a:[ a_class [ "knowledge-container" ] ]
             [ icon_button @@ icon "git/git-original" "Git"
             ; icon_button @@ icon ~path:"/static/" "neovim" "Neovim"
             ])
       ]
;;
