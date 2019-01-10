;; Copyright 2018 Zach Flynn
;; Licensed under the 3-clause BSD license, included as the file COPYING in this repository or
;; available online at: https://opensource.org/licenses/BSD-3-Clause

(use-modules (ice-9 regex))
(use-modules (ice-9 textual-ports))

(define page-list
  (list "index" "research" "teaching" "programs" "links" "102" "310"))

(define-syntax create-pattern
  (syntax-rules ()
    ((create-pattern lit exp)
     (lambda (text)
       (regexp-substitute
	#f (string-match
	    (string-append "\\\\\\\\" lit)
	    text)
	'pre
	exp
	'post)))))

(define footer-replace
  (create-pattern
   "FOOTER"
   (string-append "\n<hr>\nThis site last updated: "
                  (strftime "%c" (localtime (current-time)))
                  "\n<br>Copyright 2018 Zach Flynn.")))

(define analytics-replace
  (create-pattern "ANALYTICS"
		  "<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-59441513-2\"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-59441513-2');
</script>"))

(define meta-replace
  (create-pattern "META"
		  "<meta name=\"description\" content=\"Zach Flynn is an economist and this website has links to his research.\">
    <meta name=\"keywords\" content=\"economics,Zach Flynn,productivity,industrial organization\">
    <meta name=\"author\" content=\"Zach Flynn\">"))


(map
 (lambda (page)

   (define file
     (string-append page ".html"))

   (define src
     (string-append page ".pre.html"))

   (define header-replace
     (create-pattern
      "HEADER"
      (let* ((header-text "<h1>Zach Flynn</h1>
  <hr>
  <a href=\"index.html\">Home</a>
  <a href=\"research.html\">Research</a>
  <a href=\"teaching.html\">Teaching</a>
  <a href=\"programs.html\">Programs</a>
  <a href=\"links.html\">Links</a>
  <hr>
  <a href=\"https://github.com/flynnzac/cv/raw/master/cv.pdf\">Curriculum Vitae</a><br>
  <address>
    Email: <a href=\"mailto:zlflynn@gmail.com\">zlflynn@gmail.com</a>
  </address>
  <hr>")
	     (cur-match
	      (string-match
	       (string-append "<a href=\\\""
			      file
			      "\\\">([a-zA-Z]+)</a>")
	       header-text)))
	(if cur-match
	    (regexp-substitute #f cur-match 'pre
			       (string-append "<b><a href=\"" file "\">") 1 "</a></b>" 'post)
	    header-text))))


   (let ((output-port (open-file file "w"))
	 (main-text (get-string-all (open-file src "r"))))
     (display
      (meta-replace
       (analytics-replace
	(footer-replace
	 (header-replace
	  main-text))))
      output-port)
     (close-port output-port)))
 page-list)




