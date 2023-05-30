let template_to_html fs_name json_o =
  let lines = Arg.read_arg @@ "./templates/" ^ fs_name ^ ".html" in
  let str = Core.Array.fold lines ~init:"" ~f:(fun acc line -> acc ^ "\n" ^ line) in
  let open Mustache in
  render (of_string str) json_o
;;
