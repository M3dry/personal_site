let template_to_html fs_name models =
  let open Jingoo in
  Jg_template.from_file ("./templates/" ^ fs_name ^ ".jingoo") ~models
;;
