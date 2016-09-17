let render_table wss =
    let rec transpose xss = 
        if List.for_all (fun x -> x = []) xss
        then []
        else
            let safe_xss = List.map (fun l -> if l = [] then [""] else l) xss
            in (List.map List.hd safe_xss) :: transpose (List.map List.tl safe_xss)
    in
    let rec to_len l = if l == 0
                   then (fun _ -> [])
                   else (function
                   | []      -> "" :: to_len (l - 1) []
                   | x :: xs -> x  :: to_len (l - 1) xs)
    in
    let allign_table xss =
        let max_len = List.fold_right max (List.map List.length xss) 0 in
        List.map (to_len max_len) xss
    in
    let allign_column ws =
        let ws' = List.map (fun s -> String.concat "" [" "; s; " "]) ws in
        let max_len = List.fold_right max (List.map String.length ws') 0 in
        List.map (fun s -> s ^ String.make (max_len - String.length s) ' ') ws'
    in
    let sep1 ex = 
         String.concat "+" (List.map (fun s -> String.make (String.length s) '-') ex)
    in
    let tss = transpose (List.map allign_column (allign_table wss)) in
    let headers = List.hd tss in
    let table = List.map (fun ws -> String.concat "|" ws) tss in
    String.concat "\n" [List.hd table; sep1 headers; String.concat "\n" (List.tl table)]


let _ = Printf.printf "%s\n" (render_table [""              :: Utils.get_lines "test_lists/descriptions_list.txt";
                                            "OCanren (OPT)" :: Utils.get_lines "results/res_ocanren_opt.txt";
                                            "OCanren"       :: Utils.get_lines "results/res_ocanren.txt";
                                            "microKanren"   :: Utils.get_lines "results/res_micro.txt";
                                            "miniKanren"    :: Utils.get_lines "results/res_mini.txt";
                                            "fasterKanren"  :: Utils.get_lines "results/res_faster.txt"])
