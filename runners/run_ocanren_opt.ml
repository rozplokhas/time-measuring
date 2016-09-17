let _ =
  let tests = Utils.get_lines "test_lists/ocanren_opt_list.txt" in
  let oc = open_out "results/res_ocanren_opt.txt" in
  List.iter (fun f_name -> Printf.fprintf oc "%f\n" @@ Utils.run_test @@ AllTests.get_test f_name) tests
