let get_lines file_name = 
    let ic = open_in file_name in
    let try_read () =
        try Some (input_line ic) with End_of_file -> None
    in
    let rec loop acc = match try_read () with
        | Some s -> loop (s :: acc)
        | None -> close_in ic; List.rev acc
    in
    loop []

let make () =
  let origin = (Unix.times ()).tms_utime in
  (fun () ->
    (Unix.times ()).tms_utime -. origin
  )

let run_test test =
  let t = make () in
  test ();
  t ()
