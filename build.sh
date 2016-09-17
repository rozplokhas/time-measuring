#! /bin/bash
ocamlc   -rectypes -o runners/run_ocanren     -pp "camlp5o pa_minikanren.cmo pa_log.cmo pa_gt.cmo -L `camlp5 -where`" -I `ocamlfind -query GT` -I `ocamlfind -query MiniKanren` GT.cma  MiniKanren.cma  unix.cma  Utils.ml AllTests.ml runners/run_ocanren.ml
ocamlopt -rectypes -o runners/run_ocanren_opt -pp "camlp5o pa_minikanren.cmo pa_log.cmo pa_gt.cmo -L `camlp5 -where`" -I `ocamlfind -query GT` -I `ocamlfind -query MiniKanren` GT.cmxa MiniKanren.cmxa unix.cmxa Utils.ml AllTests.ml runners/run_ocanren_opt.ml
ocamlc -o print_result unix.cma Utils.ml Printer.ml
