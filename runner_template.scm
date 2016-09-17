(define float-time
    (lambda (t)
        (+ (time-second t) (/ (time-nanosecond t) 1e9))))

(define run-test
    (lambda (fun)
        (let ((startTime (current-time)))
            (fun)
            (- (float-time (current-time)) (float-time startTime)))))

(define read-tests
    (lambda (port)
        (let ((x (read port)))
            (if (eof-object? x)
                `()
                (cons x (read-tests port))))))

(define print-in-port
    (lambda (port)
        (lambda (obj)
            (display obj port)
            (display "\n" port))))


(define in (open-input-file tests-file))
(define out (open-file-output-port output-file (file-options no-fail) (buffer-mode block) (native-transcoder)))

(define times (map run-test (map eval (read-tests in))))
(map (print-in-port out) (reverse times))

(close-input-port in)
(close-output-port out)
